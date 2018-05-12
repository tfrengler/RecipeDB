<cfcomponent output="false" >
<cfprocessingdirective pageEncoding="utf-8" />	

	<cffunction name="main" access="public" returntype="struct" output="false" hint="" >
		<cfargument name="filterSettings" type="struct" required="false" default="#structNew()#" /> 

		<cfset var returnData = {
 			statuscode: 0,
 			data: arrayNew(1)
 		} />

 		<cfset var currentFilterSetting = "" />
 		<cfset var currentRecipeData = structNew() />
		<cfset var userDisplayName = "" />
		<cfset var filteredRecipes = queryNew("") />
		<cfset var columnsToSelect = "RecipeID,Name,DateCreated,DateTimeLastModified,CreatedByUser,Published,Picture" />

		<cfset var allRecipes = createObject("component", "Models.Recipe").getData(datasource=application.settings.datasource) >
		<cfset var users = createObject("component", "Models.User").getData( 
			datasource=application.settings.datasource,
			columnList="UserID,DisplayName",
			cachedWithin=createTimespan(0, 1, 0, 0)
		) />

		<!--- 
 			The reason we do this is because the way the query is set up it checks for existence of fields in the argument.
 			This makes sense when we apply a filter on the page because it's a form submission and thus only the checkboxes
 			that are selected are actually present in the FORM-scope.

 			However when we come in from the menu the default values are applied and we get those from the User in the session
 			scope, which returns us a struct full with all the settings as keys as booleans, which throws our lovely query off
 		 --->
 		<cfloop collection=#arguments.filterSettings# item="currentFilterSetting" >
 			<cfif arguments.filterSettings[currentFilterSetting] IS false >
 				<cfset structDelete(arguments.filterSettings, currentFilterSetting) />
 			</cfif>
 		</cfloop>

		<cfif structIsEmpty(arguments.filterSettings) IS false >
			<cfquery name="filteredRecipes" dbtype="query" >
				SELECT #columnsToSelect#
				FROM allRecipes
				WHERE 1 = 1

				<cfif 	
					structKeyExists(arguments.filterSettings, "mineOnly") OR
					structKeyExists(arguments.filterSettings, "minePrivate") OR
					structKeyExists(arguments.filterSettings, "minePrivate") OR
					structKeyExists(arguments.filterSettings, "minePublic") OR
					structKeyExists(arguments.filterSettings, "mineNoPicture") 
				>
						AND CreatedByUser = #session.currentUser.getId()#
					<cfelseif structKeyExists(arguments.filterSettings, "otherUsersOnly") >
						AND CreatedByUser != #session.currentUser.getId()#
					<cfelse>
				</cfif>

				<cfif structKeyExists(arguments.filterSettings, "mineEmpty") >
					AND char_length(Ingredients) = 0
					AND char_length(Description) = 0
					AND char_length(Instructions) = 0
				</cfif>

				<cfif structKeyExists(arguments.filterSettings, "minePrivate") AND structKeyExists(arguments.filterSettings, "minePublic") IS false >
					AND Published = false
				</cfif>

				<cfif structKeyExists(arguments.filterSettings, "minePublic") AND structKeyExists(arguments.filterSettings, "minePrivate") IS false >
					AND Published = true
				</cfif>

				<cfif structKeyExists(arguments.filterSettings, "mineNoPicture") >
					AND char_length(Picture) = 0
				</cfif>

			</cfquery>
		<cfelse>
			<cfquery name="FilteredRecipes" dbtype="query" >
				SELECT #columnsToSelect#
				FROM allRecipes
			</cfquery>
		</cfif>

		<cfloop query="filteredRecipes" >

			<cfif FilteredRecipes.CreatedByUser IS NOT session.currentUser.getId() >
				<cfif FilteredRecipes.Published IS false >
					<cfcontinue />
				</cfif>
			</cfif>

			<cfset currentRecipeData = {
				recipeID: FilteredRecipes.RecipeID,
				name: FilteredRecipes.Name,
				dateCreated: FilteredRecipes.DateCreated,
				dateTimeLastModified: FilteredRecipes.DateTimeLastModified,
				published: FilteredRecipes.Published
			} />

			<cfquery name="UserDisplayName" dbtype="query" >
				SELECT DisplayName
				FROM Users
				WHERE UserID = <cfqueryparam sqltype="BIGINT" value=#FilteredRecipes["CreatedByUser"]# />
			</cfquery>

			<cfset currentRecipeData.createdByUser = UserDisplayName["DisplayName"] />

			<cfif len(FilteredRecipes.Picture) GT 0 >
				<cfset currentRecipeData.picture = "Modules/RecipeImageDownloader.cfm?fileName=#FilteredRecipes.Picture#.png" />
			<cfelse>
				<cfset currentRecipeData.picture = "Assets/Pictures/Standard/foodexample.jpg" />
			</cfif>

			<cfset arrayAppend(returnData.data, currentRecipeData) />
		</cfloop>

		<cfreturn returnData />
	</cffunction>

</cfcomponent>