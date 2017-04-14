<cfcomponent output="false" >
<cfprocessingdirective pageEncoding="utf-8" />

	<cffunction name="getUserSettingsView" access="remote" returntype="string" returnformat="plain" output="false" hint="" >

		<cfset var ReturnData = "" />
		<cfset var ViewArguments = {} />
		<cfset var CurrentUser = session.CurrentUser />

		<cfset ViewArguments.Username = CurrentUser.getUsername() />
		<cfset ViewArguments.DisplayName = CurrentUser.getDisplayName() />
		<cfset ViewArguments.AccountCreationDate = CurrentUser.getDateCreated() />
		<cfset ViewArguments.TimesLoggedIn = CurrentUser.getTimesLoggedIn() />
		<cfset ViewArguments.BrowserLastUsed = CurrentUser.getBrowserLastUsed() />

		<!--- NOTE TO SELF: Use forward slashes for cfmodule paths that use mappings, derp --->
		<cfsavecontent variable="ReturnData" >
			<cfmodule template="/Views/UserSettings.cfm" attributecollection="#ViewArguments#" >
		</cfsavecontent>

		<cfheader name="Content-Type" value="text/html;charset=UTF-8" />
		<cfreturn ReturnData />
	</cffunction>

</cfcomponent>