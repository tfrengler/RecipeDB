<cfcomponent output="false" >
<cfprocessingdirective pageEncoding="utf-8" />

	<cffunction name="getUserSettingsView" access="public" returntype="struct" output="false" hint="" >
		<cfargument name="user" type="Models.User" required="true" hint="" />

		<cfset var returnData = {
 			statuscode: 0,
 			data: structNew()
 		} />

		<cfset var UserAgentStringResult = "" />
		<cfset var UserAgentStringForView = arguments.user.getBrowserLastUsed() />

		<cfif structKeyExists(session, "UserAgent") IS false >

			<cfhttp url="http://useragentstring.com/" method="post" timeout="5" throwonerror="false" result="UserAgentStringResult" >
				<cfhttpparam type="formfield" name="uas" value="#arguments.user.getBrowserLastUsed()#" />
				<cfhttpparam type="formfield" name="getJSON" value="all" />
			</cfhttp>

			<cfif UserAgentStringResult.statuscode IS "200 OK" AND UserAgentStringResult.mimetype IS "application/json" >

				<cftry>
					<cfset UserAgentStringResult = deserializeJSON(UserAgentStringResult.filecontent) />
					<cfset session.UserAgent = UserAgentStringResult />

					<cfcatch>
						<!--- Nuthin' --->
					</cfcatch>
				</cftry>
			</cfif>

		</cfif>

		<cfif structKeyExists(session, "UserAgent") AND isStruct(session.UserAgent) >

			<cfif structKeyExists(session.UserAgent, "agent_name") AND len(session.UserAgent.agent_name) GT 0 >
				<cfset UserAgentStringForView = session.UserAgent.agent_name />
			<cfelse>
				<cfset UserAgentStringForView = "Unknown browser" />
			</cfif>

			<cfif structKeyExists(session.UserAgent, "agent_version") AND len(session.UserAgent.agent_version) GT 0 >
				<cfset UserAgentStringForView = (UserAgentStringForView & " #session.UserAgent.agent_version#") />
			<cfelse>
				<cfset UserAgentStringForView = (UserAgentStringForView & ", unknown version") />
			</cfif>

			<cfif structKeyExists(session.UserAgent, "os_name") AND len(session.UserAgent.os_name) GT 0 >
				<cfset UserAgentStringForView = (UserAgentStringForView & ", running on #session.UserAgent.os_name#") />
			<cfelse>
				<cfset UserAgentStringForView = (UserAgentStringForView & ", running on an unknown OS") />
			</cfif>

		</cfif>

		<cfset returnData.data.username = arguments.user.getUsername() />
		<cfset returnData.data.displayName = arguments.user.getDisplayName() />
		<cfset returnData.data.accountCreationDate = arguments.user.getDateCreated() />
		<cfset returnData.data.timesLoggedIn = arguments.user.getTimesLoggedIn() />
		<cfset returnData.data.browserLastUsed = UserAgentStringForView />

		<cfreturn returnData />
	</cffunction>

	<!--- AJAX METHOD --->
	<cffunction name="changeUserSettings" access="public" returntype="struct" returnformat="JSON" output="false" hint="" >
		<cfargument name="newDisplayName" type="string" required="true" hint="" />
		<cfargument name="newUserName" type="string" required="true" hint="" />

		<cfset var returnData = {
 			statuscode: 0,
 			data: ""
 		} />

 		<cfif trim(len(arguments.newDisplayName)) IS 0 AND trim(len(arguments.newUserName)) IS 0 >
 			<cfset returnData.statuscode = 1 />
 			<cfreturn returnData />
 		</cfif>

		<cfset var ChangesMade = false />
		<cfset var UserInterface = createObject("component", "Models.User") />

		<cfset var UserSearch = UserInterface.getBy( 
			columnToSearchOn="UserName",
			searchOperator="equal to",
			searchData=trim(arguments.newUserName),
			datasource="#application.settings.datasource#"
		) />

		<!--- If a user tries to change their username and it happens to already exist we need to inform them --->
		<cfif session.CurrentUser.getUsername() NEQ arguments.NewUserName AND UserSearch.RecordCount GT 0 >

			<cfset returnData.statuscode = 2 />
			<cfreturn returnData />

		</cfif>

		<cfif session.CurrentUser.getDisplayName() NEQ arguments.NewDisplayName >
			<cfset session.CurrentUser.setDisplayName(Name=arguments.NewDisplayName) />
			<cfset ChangesMade = true />
		</cfif>

		<cfif session.CurrentUser.getUsername() NEQ arguments.NewUserName >
			<cfset session.CurrentUser.setUserName(Name=arguments.NewUserName) />
			<cfset ChangesMade = true />
		</cfif>

		<cfif ChangesMade >
			<cfset session.CurrentUser.save() />
		</cfif>

		<cfreturn returnData />
	</cffunction>

	<!--- AJAX METHOD --->
	<cffunction name="changePassword" access="public" returntype="struct" returnformat="JSON" output="false" hint="" >
		<cfargument name="newPassword" type="string" required="true" hint="" />

		<cfset var returnData = {
 			statuscode: 0,
 			data: ""
 		} />

		<cfif len(arguments.newPassword) LT 4 >

			<cfheader statuscode="500" />
			<cfset returnData.statuscode = 1 />
			<cfreturn returnData />

		</cfif>

		<cfif len(arguments.newPassword) GT 24 >

			<cfheader statuscode="500" />
			<cfset returnData.statuscode = 2 />
			<cfreturn returnData />

		</cfif>

		<cfset session.currentUser.changePassword(
			securityManager=application.securityManager,
			password=arguments.newPassword
		) />

		<cfset session.currentUser.save() >

		<cfreturn returnData />
	</cffunction>

</cfcomponent>