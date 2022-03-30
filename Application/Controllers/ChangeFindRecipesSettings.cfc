<cfcomponent output="false" >

	<!--- AJAX METHOD --->
	<cffunction name="main" access="public" returntype="struct" returnformat="JSON" output="false" hint="" >
		<cfargument name="settings" type="struct" required="false" default="#structNew()#" />

		<cfset var returnData = {
			statuscode: 0,
			data: ""
		} />

		<cfset var currentKey = "" />
		<cfset var expectedKeys = "listType,sortOnColumn,filter" />
		<cfset var expectedFilterKeys = "mineOnly,minePublic,minePrivate,mineEmpty,mineNoPicture,othersOnly" />

		<cfif structIsEmpty(arguments.settings) >

			<cfheader statuscode="500" />
			<cfset returnData.statuscode = 1 />
			<cfreturn returnData />

		</cfif>

		<cfif listLen(structKeyList(arguments.settings)) IS NOT listLen(expectedKeys) >

			<cfheader statuscode="500" />
			<cfset returnData.statuscode = 2 />
			<cfset returnData.data = listLen(structKeyList(arguments.settings)) />
			<cfreturn returnData />

		</cfif>

		<cfloop list=#expectedKeys# item="currentKey" >
			<cfif structKeyExists(arguments.settings, currentKey) IS false >

				<cfheader statuscode="500" />
				<cfset returnData.statuscode = 3 />
				<cfset returnData.data = currentKey />
				<cfreturn returnData />

			</cfif>
		</cfloop>

		<cfif listLen(structKeyList(arguments.settings.filter)) IS NOT listLen(expectedFilterKeys) >

			<cfheader statuscode="500" />
			<cfset returnData.statuscode = 4 />
			<cfset returnData.data = listLen(structKeyList(arguments.settings.filter)) />
			<cfreturn returnData />

		</cfif>

		<cfloop list=#expectedFilterKeys# item="currentKey" >
			<cfif structKeyExists(arguments.settings.filter, currentKey) IS false >

				<cfheader statuscode="500" />
				<cfset returnData.statuscode = 5 />
				<cfset returnData.data = currentKey />
				<cfreturn returnData />

			</cfif>
		</cfloop>

		<cfset session.currentUser.Settings_FindRecipes_ListType 				= arguments.settings.listType />
		<cfset session.currentUser.Settings_FindRecipes_SortOnColumn 			= arguments.settings.sortOnColumn />
		<cfset session.currentUser.Settings_FindRecipesFilterOn_MineOnly 		= arguments.settings.filter.mineOnly />
		<cfset session.currentUser.Settings_FindRecipesFilterOn_MinePublic 		= arguments.settings.filter.minePublic />
		<cfset session.currentUser.Settings_FindRecipesFilterOn_MinePrivate	 	= arguments.settings.filter.minePrivate />
		<cfset session.currentUser.Settings_FindRecipesFilterOn_MineEmpty 		= arguments.settings.filter.mineEmpty />
		<cfset session.currentUser.Settings_FindRecipesFilterOn_MineNoPicture 	= arguments.settings.filter.mineNoPicture />
		<cfset session.currentUser.Settings_FindRecipesFilterOn_OtherUsersOnly 	= arguments.settings.filter.othersOnly />

		<cfdump var=#session.currentUser.getSettings()# format="html" output="C:/Temp/Debug2.html" />

		<cfset session.currentUser.saveSettings() />

		<cfreturn returnData />
	</cffunction>

</cfcomponent>