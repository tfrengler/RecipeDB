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
			ID=CurrentRecipeID,
			Datasource=application.Settings.Datasource
		) />

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
			<cfthrow message="The name of the new recipe must not be empty" />
		</cfif>

		<cfset var ReturnData = {
			DuplicatesFound: false,
			NewRecipeID: 0,
			DuplicatesView: ""
		} />

		<cfset var ViewArguments = {} />
		<cfset var MatchingRecipes = queryNew("RecipeID,Name") />
		<cfset var RecipeInterface = createObject("component", "Models.Recipe") />
		<cfset var RecipesByName = queryNew("RecipeID,Name") />
		<cfset var DuplicateRecipeObjects = arrayNew(1, true) />
		<cfset var RecipeCounter = 0 />

		<cfif arguments.CheckForDuplicates >

			<cfset RecipesByName = RecipeInterface.getData(
				ColumnList="RecipeID,Name,CreatedByUser",
				Datasource="#application.Settings.Datasource#"
			) />

			<cfquery name="MatchingRecipes" dbtype="query" >
				SELECT #RecipeInterface.getTableKey()#
				FROM RecipesByName 
				WHERE Name LIKE <cfqueryparam sqltype="LONGVARCHAR" value="%#arguments.Name#%" maxlength="100" />
				ORDER BY #RecipeInterface.getTableKey()# ASC;
			</cfquery>

			<cfif MatchingRecipes.RecordCount GT 0 >
				<cfset ReturnData.DuplicatesFound = true />
				<cfset ViewArguments.DuplicateAmount = MatchingRecipes.RecordCount />

				<cfloop list="#valueList(MatchingRecipes.RecipeID)#" index="CurrentRecipeID" >
					
					<cfif RecipeCounter GT 50 >
						<cfset ViewArguments.ExcessDuplicateAmount = (MatchingRecipes.RecordCount - 50) />
						<cfbreak/>
					</cfif>

					<cfset arrayAppend(
						DuplicateRecipeObjects,  
						createObject("component", "Models.Recipe").init( 
							ID=CurrentRecipeID,
							Datasource=application.Settings.Datasource
						)
					) >
					<cfset RecipeCounter = (RecipeCounter + 1) />

				</cfloop>

				<cfset ViewArguments.DuplicateRecipeObjects = DuplicateRecipeObjects />

				<cfsavecontent variable="ReturnData.DuplicatesView" >
					<cfmodule template="/Views/DuplicateRecipesList.cfm" attributecollection="#ViewArguments#" >
				</cfsavecontent>
			</cfif>
		</cfif>

		<cfif MatchingRecipes.RecordCount IS 0 >
			<cfset ReturnData.NewRecipeID = RecipeInterface.createNew(
				UserID=session.CurrentUser.getUserID(),
				Name=arguments.Name,
				Datasource=application.Settings.Datasource
			) />
		</cfif>

		<!--- <cfheader name="Content-Type" value="application/json;charset=UTF-8" /> --->
		<cfreturn ReturnData />
	</cffunction>

</cfcomponent>