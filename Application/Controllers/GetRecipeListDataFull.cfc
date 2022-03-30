<cfcomponent output="false" >

	<cffunction name="main" access="public" returntype="struct" output="false" hint="" >
		<cfargument name="filterSettings" type="struct" required="false" default="#{}#" />

		<cfset var returnData = {
			statuscode: 0,
			data: []
		} />

		<cfset var allRecipes = Models.Recipe::GetData() >
		<cfset var users = Models.User::GetData(columnList="UserID,DisplayName") />

		<cfset var ColumnNamesFromQuery = "" />
		<cfset var CurrentColumnName = "" />
		<cfset var CurrentRecipeData = {} />
		<cfset var UserDisplayName = "" />
		<cfset var CurrentColumnFromCurrentRowInQuery = "" />
		<cfset var UserIDColumns = "CreatedByUser,LastModifiedByUser" />
		<cfset var FilteredRecipes = null />

		<cfif NOT structIsEmpty(arguments.filterSettings) >
			<cfquery name="FilteredRecipes" dbtype="query" >
				SELECT RecipeID,Name,DateTimeCreated,DateTimeLastModified,CreatedByUser,Published
				FROM allRecipes
				WHERE 1 = 1

				<cfif
					structKeyExists(arguments.filterSettings, "mineOnly") OR
					structKeyExists(arguments.filterSettings, "minePrivate") OR
					structKeyExists(arguments.filterSettings, "minePrivate") OR
					structKeyExists(arguments.filterSettings, "minePublic") OR
					structKeyExists(arguments.filterSettings, "mineNoPicture")
				>
						AND CreatedByUser = #session.currentUser.UserID#
					<cfelseif structKeyExists(arguments.filterSettings, "othersOnly") >
						AND CreatedByUser != #session.currentUser.UserID#
					<cfelse>
				</cfif>

				<cfif structKeyExists(arguments.filterSettings, "mineEmpty") >
					AND char_length(Ingredients) = 0
					AND char_length(Description) = 0
					AND char_length(Instructions) = 0
				</cfif>

				<cfif structKeyExists(arguments.filterSettings, "minePrivate") AND NOT structKeyExists(arguments.filterSettings, "minePublic") >
					AND Published = false
				</cfif>

				<cfif structKeyExists(arguments.filterSettings, "minePublic") AND NOT structKeyExists(arguments.filterSettings, "minePrivate") >
					AND Published = true
				</cfif>

				<cfif structKeyExists(arguments.filterSettings, "mineNoPicture") >
					AND char_length(Picture) = 0
				</cfif>

			</cfquery>
		<cfelse>
			<cfquery name="FilteredRecipes" dbtype="query" >
				SELECT RecipeID,Name,DateTimeCreated,DateTimeLastModified,CreatedByUser,Published
				FROM allRecipes
			</cfquery>
		</cfif>

		<cfset ColumnNamesFromQuery = FilteredRecipes.ColumnList />

		<cfloop query="FilteredRecipes" >

			<cfif FilteredRecipes.CreatedByUser IS NOT session.currentUser.GetUserId() >
				<cfif NOT FilteredRecipes.Published >
					<cfcontinue />
				</cfif>
			</cfif>

			<cfloop list=#ColumnNamesFromQuery# index="CurrentColumnName" >

				<cfset CurrentColumnFromCurrentRowInQuery = FilteredRecipes[CurrentColumnName] />

				<cfset structInsert(CurrentRecipeData, CurrentColumnName, {}) />
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
						<cfset structInsert(CurrentRecipeData[CurrentColumnName], "display", Components.Localizer::GetDisplayDateTime(CurrentColumnFromCurrentRowInQuery), true) />

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
			<cfset CurrentRecipeData = {} />

		</cfloop>

		<cfreturn returnData />
	</cffunction>

</cfcomponent>