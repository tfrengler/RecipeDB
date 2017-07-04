<cfcomponent output="false" >
<cfprocessingdirective pageEncoding="utf-8" />

	<cffunction name="getAddRecipeView" access="remote" returntype="string" returnformat="plain" output="false" hint="" >

		<cfset var ReturnData = "" />
		<cfset var ViewArguments = {} />

		<!--- NOTE TO SELF: Use forward slashes for cfmodule paths that use mappings, derp --->
		<cfsavecontent variable="ReturnData" >
			<cfmodule template="/Views/AddRecipe.cfm" attributecollection="#ViewArguments#" >
		</cfsavecontent>

		<cfheader name="Content-Type" value="text/html;charset=UTF-8" />
		<cfreturn ReturnData />
	</cffunction>

	<cffunction name="getRecipeView" access="remote" returntype="string" returnformat="plain" output="false" hint="" >
		<cfargument name="RecipeID" type="numeric" required="true" />

		<cfset var ReturnData = "" />
		<cfset var ViewArguments = {} />

		<cfset var Recipe = createObject("component", "Models.Recipe").init( 
			ID=arguments.RecipeID,
			Datasource=application.Settings.Datasource
		) />

		<cfset ViewArguments.RecipeID = Recipe.getID() />
		<cfset ViewArguments.Name = Recipe.getName() />
		<cfset ViewArguments.DateCreated = Recipe.getDateCreated() />
		<cfset ViewArguments.DateTimeLastModified = Recipe.getDateTimeLastModified() />
		<cfset ViewArguments.CreatedByUserName = Recipe.getCreatedByUser().getDisplayName() />
		<cfset ViewArguments.CreatedByUserID = Recipe.getCreatedByUser().getID() />
		<cfset ViewArguments.LastModifiedByUser = Recipe.getLastModifiedByUser().getDisplayName() />
		<cfset ViewArguments.Ingredients = Recipe.getIngredients() />
		<cfset ViewArguments.Description = Recipe.getDescription() />
		<cfset ViewArguments.Picture = Recipe.getPicture() />
		<cfset ViewArguments.Instructions = Recipe.getInstructions() />
		<!--- <cfset ViewArguments.Comments = Recipe.getComments() /> --->

		<!--- NOTE TO SELF: Use forward slashes for cfmodule paths that use mappings, derp --->
		<cfsavecontent variable="ReturnData" >
			<cfmodule template="/Views/Recipe.cfm" attributecollection="#ViewArguments#" >
		</cfsavecontent>

		<cfheader name="Content-Type" value="text/html;charset=UTF-8" />
		<cfreturn ReturnData />
	</cffunction>

	<cffunction name="addNewRecipe" access="remote" returntype="struct" returnformat="JSON" output="false" hint="" >
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

					<cfset CurrentRecipe = createObject("component", "Models.Recipe").init( 
							ID=CurrentRecipeID,
							Datasource=application.Settings.Datasource
						) 
					/>

					<cfset DuplicateRecipeData.ID = CurrentRecipe.getID() />
					<cfset DuplicateRecipeData.Name = CurrentRecipe.getName() />
					<cfset DuplicateRecipeData.Owner = CurrentRecipe.getCreatedByUser().getDisplayName() />

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

	<cffunction name="getRecipeListView" access="remote" returntype="string" returnformat="plain" output="false" hint="" >

		<cfset var ReturnData = "" />

		<cfsavecontent variable="ReturnData" >
			<cfmodule template="/Views/RecipeList.cfm" >
		</cfsavecontent>

		<cfheader name="Content-Type" value="text/html;charset=UTF-8" />
		<cfreturn ReturnData />

	</cffunction>

	<cffunction name="getRecipeListData" access="remote" returntype="query" returnformat="JSON" output="false" hint="" >

		<cfset var ReturnData = createObject("component", "Models.Recipe").getData( Datasource=application.Settings.Datasource ) >
		<cfreturn ReturnData />

	</cffunction>

</cfcomponent>