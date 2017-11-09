<cfcomponent output="false" >
<cfprocessingdirective pageEncoding="utf-8" />

	<cffunction name="getRecipeView" access="public" returntype="struct" output="false" hint="" >
		<cfargument name="recipeID" type="numeric" required="true" />
		<cfargument name="currentUser" type="Models.User" required="true" />

		<cfset var ReturnData = {
			status: "",
			errorcode: 0,
			data: structNew()
		} />

		<cfset var Recipe = createObject("component", "Models.Recipe").init( 
			ID=arguments.RecipeID,
			Datasource=application.Settings.Datasource
		) />

		<cfif Recipe.getCreatedByUser().getId() IS NOT arguments.currentUser.getId() >
			<cfif Recipe.getPublished() IS false >

				<cfset ReturnData.status = "NOK" />
				<cfset ReturnData.errorcode = 1 />
				<cfreturn ReturnData />

			</cfif>
		</cfif>

		<cfset ReturnData.data.RecipeID = Recipe.getID() />
		<cfset ReturnData.data.Name = Recipe.getName() />
		<cfset ReturnData.data.DateCreated = Recipe.getDateCreated() />
		<cfset ReturnData.data.DateTimeLastModified = Recipe.getDateTimeLastModified() />
		<cfset ReturnData.data.CreatedByUserName = Recipe.getCreatedByUser().getDisplayName() />
		<cfset ReturnData.data.CreatedByUserID = Recipe.getCreatedByUser().getID() />
		<cfset ReturnData.data.LastModifiedByUser = Recipe.getLastModifiedByUser().getDisplayName() />
		<cfset ReturnData.data.Ingredients = Recipe.getIngredients() />
		<cfset ReturnData.data.Description = Recipe.getDescription() />
		<cfset ReturnData.data.Picture = Recipe.getPicture() />
		<cfset ReturnData.data.Instructions = Recipe.getInstructions() />
		<cfset ReturnData.data.Published = Recipe.getPublished() />
		<!--- <cfset ReturnData.Comments = Recipe.getComments() /> --->

		<cfreturn ReturnData />
	</cffunction>

	<cffunction name="addNewRecipe" access="public" returntype="struct" returnformat="JSON" output="false" hint="" >
		<cfargument name="Name" type="string" required="true" />
		<cfargument name="CheckForDuplicates" type="boolean" required="false" default="true" />

		<cfif len(arguments.Name) IS 0 >
			<cfthrow message="Error adding new recipe" detail="The name of the new recipe must not be empty. This should have been caught on the front end." />
		</cfif>

		<cfset var ReturnData = {
			DuplicatesFound: false,
			NewRecipeID: 0,
			DuplicatesView: "",
			NewRecipeView: ""
		} />

		<cfset var DuplicateViewArguments = {} />
		<cfset var RecipeViewArguments = {} />
		<cfset var MatchingRecipes = queryNew("RecipeID,Name") />
		<cfset var RecipeInterface = createObject("component", "Models.Recipe") />
		<cfset var RecipesByName = queryNew("RecipeID,Name") />
		<cfset var DuplicateRecipes = arrayNew(1, true) />
		<cfset var RecipeCounter = 0 />
		<cfset var CurrentRecipeID = 0 />
		<cfset var CurrentRecipe = "" />
		<cfset var DuplicateRecipeData = structNew() />
		<cfset var NewRecipe = "" />

		<cfif arguments.CheckForDuplicates >

			<cfset RecipesByName = RecipeInterface.getData(
				ColumnList="RecipeID,Name,CreatedByUser",
				Datasource="#application.Settings.Datasource#"
			) />

			<cfquery name="MatchingRecipes" dbtype="query" >
				SELECT #RecipeInterface.getTableKey()#
				FROM RecipesByName 
				WHERE Name LIKE <cfqueryparam sqltype="LONGVARCHAR" value="%#trim(arguments.Name)#%" maxlength="100" />
				ORDER BY #RecipeInterface.getTableKey()# ASC;
			</cfquery>

			<cfif MatchingRecipes.RecordCount GT 0 >
				<cfset ReturnData.DuplicatesFound = true />
				<cfset DuplicateViewArguments.DuplicateAmount = MatchingRecipes.RecordCount />

				<cfloop list="#valueList(MatchingRecipes.RecipeID)#" index="CurrentRecipeID" >

					<cfset DuplicateRecipeData = structNew() />

					<cfif RecipeCounter GT 50 >
						<cfset DuplicateViewArguments.ExcessDuplicateAmount = (MatchingRecipes.RecordCount - 50) />
						<cfbreak/>
					</cfif>

					<!--- This feels ridiculously expensive in the long run. Might want to do something similar to getRecipeListData() instead --->
					<!--- <cfset CurrentRecipe = createObject("component", "Models.Recipe").init( 
						ID=CurrentRecipeID,
						Datasource=application.Settings.Datasource
					) />

					<cfset DuplicateRecipeData.ID = CurrentRecipe.getID() />
					<cfset DuplicateRecipeData.Name = CurrentRecipe.getName() />
					<cfset DuplicateRecipeData.Owner = CurrentRecipe.getCreatedByUser().getDisplayName() /> --->

					<cfset arrayAppend(DuplicateRecipes, DuplicateRecipeData) >
					<cfset RecipeCounter = (RecipeCounter + 1) />

				</cfloop>

				<cfset DuplicateViewArguments.DuplicateRecipes = DuplicateRecipes />

				<cfsavecontent variable="ReturnData.DuplicatesView" >
					<cfmodule template="/Views/DuplicateRecipesList.cfm" attributecollection="#DuplicateViewArguments#" >
				</cfsavecontent>

				<cfreturn ReturnData />
			</cfif>
		</cfif>

		<cfset NewRecipe = RecipeInterface.create(
			UserID=session.CurrentUser.getID(),
			Name=trim(arguments.Name),
			Datasource=application.Settings.Datasource
		 ) />

		<cfset ReturnData.NewRecipeID = NewRecipe.getID() />

		<cfreturn ReturnData />
	</cffunction>

	<cffunction name="getRecipeListData" access="public" returntype="struct" returnformat="JSON" output="false" hint="" >
		<!--- 
			Looking further down, yes I realize that the formatting of the data for viewing should be done in the VIEW
			rather than here in a backend CFC. Sadly we are not in control of the rendering of each table row since datables
			control that, hence we NEED to do it here!
		 --->

		<cfset var AllRecipes = createObject("component", "Models.Recipe").getData(
			Datasource=application.Settings.Datasource,
			ColumnList="RecipeID,Name,DateCreated,DateTimeLastModified,CreatedByUser,LastModifiedByUser,Ingredients,Published"
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
		<cfset var DateColumns = "DateTimeLastModified,DateCreated" />

		<cfset var ReturnData = {
			data: arrayNew(1)
		} />

		<cfloop query="AllRecipes" >

			<!--- 
				Yes, the bloody controller is not supposed to reach into the session-scope
				but since this bloody thing is called by AJAX this is the most secure way
			--->
			<cfif AllRecipes["CreatedByUser"] IS NOT session.currentUser.getId() >
				<cfif AllRecipes["Published"] IS false >
					<cfcontinue />
				</cfif>
			</cfif>

			<cfloop list=#ColumnNamesFromQuery# index="CurrentColumnName" >

				<cfset CurrentColumnFromCurrentRowInQuery = AllRecipes[CurrentColumnName] />

				<cfset structInsert(CurrentRecipeData, CurrentColumnName, structNew()) />
				<cfset structInsert(CurrentRecipeData[CurrentColumnName], "sortdata", "") />
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
					<cfelseif listFindNoCase(DateColumns, CurrentColumnName) GT 0 >

						<cfset structInsert(CurrentRecipeData[CurrentColumnName], "sortdata", ReReplaceNoCase(CurrentColumnFromCurrentRowInQuery, "[^0-9,]", "", "ALL"), true) />

						<!--- DateTimeLastModified is a Date and Time-stamp so we need to format it differently --->
						<cfif findNoCase("DateTimeLastModified", CurrentColumnName) GT 0 >
							<cfset structInsert(CurrentRecipeData[CurrentColumnName], "display", LSDateTimeFormat(CurrentColumnFromCurrentRowInQuery, "dd-mm-yyyy HH:nn:ss"), true) />
						<cfelse>
							<cfset structInsert(CurrentRecipeData[CurrentColumnName], "display", LSDateFormat(CurrentColumnFromCurrentRowInQuery, "DD/MM/yyyy"), true) />
						</cfif>

					<!--- For everything else, just put the data in the return data --->
					<cfelse>
						
						<!--- Normally I'd put encodeForHTML() type things in the view but 
							A: we are not in charge of rendering each row and their content and
							B: hopefully this helps neuter things that might otherwise break the JSON
						--->
						<cfset structInsert(CurrentRecipeData[CurrentColumnName], "sortdata", toString( encodeForHTML(CurrentColumnFromCurrentRowInQuery) ), true) />
						<cfset structInsert(CurrentRecipeData[CurrentColumnName], "display", toString( encodeForHTML(CurrentColumnFromCurrentRowInQuery) ), true) />

					</cfif>

				</cfif>

			</cfloop>

			<cfset arrayAppend(ReturnData.data, CurrentRecipeData) />
			<cfset CurrentRecipeData = structNew() />

		</cfloop>

		<cfreturn ReturnData />
	</cffunction>

	<cffunction name="updateRecipe" access="public" returntype="struct" returnformat="JSON" output="true" hint="" >
		<cfargument name="RecipeID" type="numeric" required="true" />
		<cfargument name="UpdateData" type="struct" required="true" />

		<cfset var ReturnData = {
			status: "",
			message: ""
		} />

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
		
		<cfif Recipe.save() >
			<cfset ReturnData.status = "OK" />
		<cfelse>
			<cfset ReturnData.status = "NOK" />
		</cfif>

		<cfreturn ReturnData />
	</cffunction>

	<cffunction name="flipPublishedStatus" access="public" returntype="struct" returnformat="JSON" output="true" hint="" >
		<cfargument name="RecipeID" type="numeric" required="true" />

		<cfset var ReturnData = {
			status: "",
			message: ""
		} />

		<cfset var Recipe = createObject("component", "Models.Recipe").init( 
			ID=arguments.RecipeID,
			Datasource=application.Settings.Datasource
		) />

		<cfif Recipe.getPublished() IS false >
			<cfset Recipe.setPublished(status=true) />
		<cfelse>
			<cfset Recipe.setPublished(status=false) />
		</cfif>

		<cfset Recipe.save() />

		<cfset ReturnData.status = "OK" />
		<cfreturn ReturnData />
	</cffunction>

	<cffunction name="deleteRecipe" access="public" returntype="struct" returnformat="JSON" output="true" hint="" >
		<cfargument name="recipeID" type="numeric" required="true" />

		<cfset var ReturnData = {
			status: "",
			message: ""
		} />

		<cfset var Recipe = createObject("component", "Models.Recipe").init( 
			ID=arguments.recipeID,
			Datasource=application.Settings.Datasource
		) />

		<cfset Recipe.delete() />

		<cfset ReturnData.status = "OK" />
		<cfreturn ReturnData />
	</cffunction>

</cfcomponent>