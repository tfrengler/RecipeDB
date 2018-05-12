<cfcomponent output="false" >
<cfprocessingdirective pageEncoding="utf-8" />

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
 
		<cfset session.currentUser.setFindRecipes_ListType(data=arguments.settings.listType) />
		<cfset session.currentUser.setFindRecipes_SortOnColumn(data=arguments.settings.sortOnColumn) />
		<cfset session.currentUser.setFindRecipesFilterOn_MineOnly(data=arguments.settings.filter.mineOnly) />
		<cfset session.currentUser.setFindRecipesFilterOn_MinePublic(data=arguments.settings.filter.minePublic) />
		<cfset session.currentUser.setFindRecipesFilterOn_MinePrivate(data=arguments.settings.filter.minePrivate) />
		<cfset session.currentUser.setFindRecipesFilterOn_MineEmpty(data=arguments.settings.filter.mineEmpty) />
		<cfset session.currentUser.setFindRecipesFilterOn_MineNoPicture(data=arguments.settings.filter.mineNoPicture) />
		<cfset session.currentUser.setFindRecipesFilterOn_OtherUsersOnly(data=arguments.settings.filter.othersOnly) />

		<cfset session.currentUser.saveSettings() />

		<cfreturn returnData />
	</cffunction>

</cfcomponent>