<cfcomponent output="false" >
<cfprocessingdirective pageEncoding="utf-8" />

	<cffunction name="getRecipeView" access="public" returntype="struct" output="false" hint="" >
		<cfargument name="recipeID" type="numeric" required="true" />
		<cfargument name="currentUser" type="Models.User" required="true" />

		<cfset var returnData = {
 			statuscode: 0,
 			data: structNew()
 		} />

 		<cfif arguments.recipeID LTE 0 >

 			<cfset returnData.statuscode = 3 />
			<cfreturn returnData />

 		</cfif>

		<cfset var RecipeInterface = createObject("component", "Models.Recipe") />

		<cfif RecipeInterface.exists(ID=arguments.recipeID, Datasource=application.settings.datasource) IS false >

			<cfset returnData.statuscode = 2 />
			<cfreturn returnData />

		</cfif>

		<cfset var Recipe = createObject("component", "Models.Recipe").init( 
			ID=arguments.RecipeID,
			Datasource=application.settings.datasource
		) />

		<cfif Recipe.getCreatedByUser().getId() IS NOT arguments.currentUser.getId() >
			<cfif Recipe.getPublished() IS false >

				<cfset returnData.statuscode = 1 />
				<cfreturn returnData />

			</cfif>
		</cfif>

		<cfset returnData.data.RecipeID = Recipe.getID() />
		<cfset returnData.data.Name = Recipe.getName() />
		<cfset returnData.data.DateCreated = Recipe.getDateCreated() />
		<cfset returnData.data.DateTimeLastModified = Recipe.getDateTimeLastModified() />
		<cfset returnData.data.CreatedByUserName = Recipe.getCreatedByUser().getDisplayName() />
		<cfset returnData.data.CreatedByUserID = Recipe.getCreatedByUser().getID() />
		<cfset returnData.data.LastModifiedByUser = Recipe.getLastModifiedByUser().getDisplayName() />
		<cfset returnData.data.Ingredients = Recipe.getIngredients() />
		<cfset returnData.data.Description = Recipe.getDescription() />
		<cfset returnData.data.Picture = Recipe.getPicture() />
		<cfset returnData.data.Instructions = Recipe.getInstructions() />
		<cfset returnData.data.Published = Recipe.getPublished() />
		<!--- <cfset returnData.Comments = Recipe.getComments() /> --->

		<cfreturn returnData />
	</cffunction>

	<!--- AJAX METHOD --->
	<cffunction name="addNewRecipe" access="public" returntype="struct" returnformat="JSON" output="false" hint="" >
		<cfargument name="Name" type="string" required="true" />

		<cfset var returnData = {
 			statuscode: 0,
 			data: 0
 		} />

		<cfif len(arguments.Name) IS 0 >

			<cfheader statuscode="500" />
			<cfset returnData.statuscode = 1 />
			<cfreturn returnData />

		</cfif>

		<cfset var recipeInterface = createObject("component", "Models.Recipe") />
		<cfset var newRecipe = "" />

		<cfset NewRecipe = RecipeInterface.create(
			UserID=session.CurrentUser.getID(),
			Name=trim(arguments.Name),
			Datasource=application.settings.datasource
		 ) />

		<cfset returnData.data = NewRecipe.getID() />

		<cfreturn returnData />
	</cffunction>

	<!--- AJAX METHOD --->
	<cffunction name="getRecipeListData" access="public" returntype="struct" returnformat="JSON" output="false" hint="" >
		<!--- 
			Looking further down, yes I realize that the formatting of the data for viewing should be done in the VIEW
			rather than here in a backend CFC. Sadly we are not in control of the rendering of each table row since datables
			control that, hence we NEED to do it here for max security!
		 --->

		<cfset var returnData = {
 			statuscode: 0,
 			data: arrayNew(1)
 		} />

		<cfset var AllRecipes = createObject("component", "Models.Recipe").getData(
			Datasource=application.Settings.Datasource,
			ColumnList="RecipeID,Name,DateCreated,DateTimeLastModified,CreatedByUser,Ingredients,Published"
		) >
		<cfset var Users = createObject("component", "Models.User").getData( 
			Datasource=application.Settings.Datasource,
			ColumnList="UserID,DisplayName"
		) />
		
		<cfset var ColumnNamesFromQuery = AllRecipes.ColumnList />
		<cfset var CurrentColumnName = "" />
		<cfset var CurrentRecipeData = structNew() />
		<cfset var UserDisplayName = "" />
		<cfset var CurrentColumnFromCurrentRowInQuery = "" />
		<cfset var UserIDColumns = "CreatedByUser,LastModifiedByUser" />

		<cfloop query="AllRecipes" >

			<!--- 
				Yes, the bloody controller is not supposed to reach into the session-scope
				but since this bloody thing is called by AJAX this is the most secure way
			--->
			<cfif AllRecipes.CreatedByUser IS NOT session.currentUser.getId() >
				<cfif AllRecipes.Published IS false >
					<cfcontinue />
				</cfif>
			</cfif>

			<cfloop list=#ColumnNamesFromQuery# index="CurrentColumnName" >

				<cfset CurrentColumnFromCurrentRowInQuery = AllRecipes[CurrentColumnName] />

				<cfset structInsert(CurrentRecipeData, CurrentColumnName, structNew()) />
				<cfset structInsert(CurrentRecipeData[CurrentColumnName], "display", "") />

				<!--- If column is empty, skip processing it --->
				<cfif len(CurrentColumnFromCurrentRowInQuery) GT 0 AND CurrentColumnFromCurrentRowInQuery IS NOT " " >

					<!--- Since users are listed by ID's we need some additional processing to get the names for display purposes --->
					<cfif listFindNoCase(UserIDColumns, CurrentColumnName) GT 0 >

						<cfquery name="UserDisplayName" dbtype="query" >
							SELECT DisplayName
							FROM Users
							WHERE UserID = <cfqueryparam sqltype="BIGINT" value="#CurrentColumnFromCurrentRowInQuery#" />;
						</cfquery>

						<cfset structInsert(CurrentRecipeData[CurrentColumnName], "sortdata", encodeForHTML(UserDisplayName["DisplayName"]), true) />
						<cfset structInsert(CurrentRecipeData[CurrentColumnName], "display", encodeForHTML(UserDisplayName["DisplayName"]), true) />
					
					<!--- Date columns cannot be sorted by normal means so we need some additional processing --->
					<cfelseif find("{ts '", CurrentColumnFromCurrentRowInQuery) GT 0 >

						<cfset structInsert(CurrentRecipeData[CurrentColumnName], "sortdata", ReReplaceNoCase(CurrentColumnFromCurrentRowInQuery, "[^0-9,]", "", "ALL"), true) />

						<!--- Date and DateTime-stamp need to be formatted differently --->
						<cfif find("00:00:00'}", CurrentColumnFromCurrentRowInQuery) GT 0 >
							<cfset structInsert(CurrentRecipeData[CurrentColumnName], "display", LSDateFormat(CurrentColumnFromCurrentRowInQuery, "DD/MM/yyyy"), true) />
						<cfelse>
							<cfset structInsert(CurrentRecipeData[CurrentColumnName], "display", LSDateTimeFormat(CurrentColumnFromCurrentRowInQuery, "dd-mm-yyyy HH:nn:ss"), true) />
						</cfif>

					<!--- For everything else, just put the data in the return data --->
					<cfelse>
						
						<!--- Normally I'd put encodeForHTML() type things in the view but 
							A: we are not in charge of rendering each row and their content and
							B: hopefully this helps neuter things that might otherwise break the JSON
						--->
						<cfset structInsert(CurrentRecipeData[CurrentColumnName], "display", toString( encodeForHTML(CurrentColumnFromCurrentRowInQuery) ), true) />

					</cfif>

				</cfif>

			</cfloop>

			<cfset arrayAppend(returnData.data, CurrentRecipeData) />
			<cfset CurrentRecipeData = structNew() />

		</cfloop>

		<cfreturn returnData />
	</cffunction>

	<!--- AJAX METHOD --->
	<cffunction name="updateRecipe" access="public" returntype="struct" returnformat="JSON" output="true" hint="" >
		<cfargument name="RecipeID" type="numeric" required="true" />
		<cfargument name="UpdateData" type="struct" required="true" />

		<cfset var returnData = {
 			statuscode: 0,
 			data: ""
 		} />

 		<cfif arguments.RecipeID LTE 0 >

 			<cfheader statuscode="500" />
 			<cfset returnData.statuscode = 1 />
 			<cfreturn returnData />

 		</cfif>

		<cfset var Recipe = createObject("component", "Models.Recipe").init( 
			ID=arguments.RecipeID,
			Datasource=application.Settings.Datasource
		) />

		<cfset Recipe.setIngredients(Data=arguments.UpdateData.ingredients) />
		<cfset Recipe.setDescription(Data=arguments.UpdateData.description) />
		<cfset Recipe.setInstructions(Data=arguments.UpdateData.instructions) />
		<cfset Recipe.setName(Data=arguments.UpdateData.name) />

		<cfset Recipe.setDateTimeLastModified(Date=createODBCdatetime(now())) />
		<cfset Recipe.setLastModifiedByUser(UserInstance=session.currentUser) />

		<cfset Recipe.save() />
		<cfset returnData.data = LSDateTimeFormat(Recipe.getDateTimeLastModified(), "dd-mm-yyyy HH:nn:ss") />

		<cfreturn returnData />
	</cffunction>

	<!--- AJAX METHOD --->
	<cffunction name="flipPublishedStatus" access="public" returntype="struct" returnformat="JSON" output="true" hint="" >
		<cfargument name="RecipeID" type="numeric" required="true" />

		<cfset var returnData = {
 			statuscode: 0,
 			data: ""
 		} />

		<cfset var Recipe = createObject("component", "Models.Recipe").init( 
			ID=arguments.RecipeID,
			Datasource=application.Settings.Datasource
		) />

		<cfif Recipe.getPublished() IS false >
			<cfset Recipe.setPublished(status=true) />
			<cfset returnData.data = true />
		<cfelse>
			<cfset Recipe.setPublished(status=false) />
			<cfset returnData.data = false />
		</cfif>

		<cfset Recipe.save() />

		<cfreturn returnData />
	</cffunction>

	<!--- AJAX METHOD --->
	<cffunction name="deleteRecipe" access="public" returntype="struct" returnformat="JSON" output="true" hint="" >
		<cfargument name="recipeID" type="numeric" required="true" />

		<cfset var returnData = {
 			statuscode: 0,
 			data: ""
 		} />

		<cfset var Recipe = createObject("component", "Models.Recipe").init( 
			ID=arguments.recipeID,
			Datasource=application.Settings.Datasource
		) />

		<cfset Recipe.delete() />

		<cfreturn returnData />
	</cffunction>

</cfcomponent>