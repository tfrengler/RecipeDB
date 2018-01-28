<cfcomponent output="false" >
<cfprocessingdirective pageEncoding="utf-8" />	

	<!--- AJAX METHOD --->
	<cffunction name="main" access="public" returntype="struct" returnformat="JSON" output="false" hint="" >
		<cfargument name="mineOnly" type="boolean" required="true" />
		<cfargument name="minePublic" type="boolean" required="true" />
		<cfargument name="minePrivate" type="boolean" required="true" />
		<cfargument name="mineEmpty" type="boolean" required="true" />
		<cfargument name="mineNoPicture" type="boolean" required="true" />
		<cfargument name="othersOnly" type="boolean" required="true" />

		<cfset var returnData = {
 			statuscode: 0,
 			data: arrayNew(1)
 		} />

		<cfset var AllRecipes = createObject("component", "Models.Recipe").getData(
			Datasource=application.Settings.Datasource
		) >
		<cfset var Users = createObject("component", "Models.User").getData( 
			Datasource=application.Settings.Datasource,
			ColumnList="UserID,DisplayName"
		) />
		
		<cfset var ColumnNamesFromQuery = "" />
		<cfset var CurrentColumnName = "" />
		<cfset var CurrentRecipeData = structNew() />
		<cfset var UserDisplayName = "" />
		<cfset var CurrentColumnFromCurrentRowInQuery = "" />
		<cfset var UserIDColumns = "CreatedByUser,LastModifiedByUser" />
		<cfset var ApplyFilter = false />
		<cfset var FilteredRecipes = queryNew("") />
		<cfset var WhereUsed = false />
		<cfset var CurrentArgument = "" />

		<cfloop collection=#arguments# item="CurrentArgument" >
			<cfif arguments[currentArgument] IS true >
				<cfset ApplyFilter = true />
				<cfbreak/>
			</cfif>
		</cfloop>

		<cfif ApplyFilter IS true >

			<cfquery name="FilteredRecipes" dbtype="query" >
				SELECT RecipeID,Name,DateCreated,DateTimeLastModified,CreatedByUser,Published
				FROM AllRecipes

				<cfif arguments.mineOnly >
					WHERE CreatedByUser = #session.currentUser.getId()#
				<cfelseif arguments.othersOnly >
					WHERE CreatedByUser != #session.currentUser.getId()#
				<cfelse>

					<cfif arguments.mineEmpty >
						WHERE char_length(Ingredients) = 0
						AND char_length(Description) = 0
						AND char_length(Instructions) = 0
						<cfset WhereUsed = true />
					</cfif>

					<cfif arguments.minePrivate IS false OR arguments.minePublic IS false >

						<cfif arguments.minePrivate >
							<cfif WhereUsed >
								AND Published = false
							<cfelse>
								WHERE Published = false
								<cfset WhereUsed = true />
							</cfif>
						</cfif>

						<cfif arguments.minePublic >
							<cfif WhereUsed >
								AND Published = true
							<cfelse>
								WHERE Published = true
								<cfset WhereUsed = true />
							</cfif>
						</cfif>
					<cfelse>
						<cfif WhereUsed >
							AND CreatedByUser = #session.currentUser.getId()#
						<cfelse>
							WHERE CreatedByUser = #session.currentUser.getId()#
						</cfif>
					</cfif>

					<cfif arguments.mineNoPicture >
						<cfif WhereUsed >
							AND char_length(Picture) = 0
						<cfelse>
							WHERE char_length(Picture) = 0
						</cfif>
					</cfif>
				</cfif>
			</cfquery>

			<cfelse>
				<cfquery name="FilteredRecipes" dbtype="query" >
					SELECT RecipeID,Name,DateCreated,DateTimeLastModified,CreatedByUser,Published
					FROM AllRecipes
				</cfquery>
		</cfif>

		<cfset ColumnNamesFromQuery = FilteredRecipes.ColumnList />

		<cfloop query="FilteredRecipes" >

			<cfif FilteredRecipes.CreatedByUser IS NOT session.currentUser.getId() >
				<cfif FilteredRecipes.Published IS false >
					<cfcontinue />
				</cfif>
			</cfif>

			<cfloop list=#ColumnNamesFromQuery# index="CurrentColumnName" >

				<cfset CurrentColumnFromCurrentRowInQuery = FilteredRecipes[CurrentColumnName] />

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

</cfcomponent>