<cfcomponent output="false" >
<cfprocessingdirective pageEncoding="utf-8" />

	<cffunction name="getUserSettingsView" access="public" returntype="struct" output="false" hint="" >

		<cfset var ReturnData = {
			status: "",
			errorcode: 0,
			data: structNew()
		} />

		<cfset var CurrentUser = session.CurrentUser />
		<cfset var UserAgentStringResult = "" />
		<cfset var UserAgentStringForView = CurrentUser.getBrowserLastUsed() />

		<!--- <cfif structKeyExists(session, "UserAgent") IS false >

			<cfhttp url="http://useragentstring.com/" method="post" timeout="5" throwonerror="false" result="UserAgentStringResult" >
				<cfhttpparam type="formfield" name="uas" value="#CurrentUser.getBrowserLastUsed()#" />
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

		</cfif> --->

		<cfset ReturnData.status = "OK" />

		<cfset ReturnData.data.username = CurrentUser.getUsername() />
		<cfset ReturnData.data.displayName = CurrentUser.getDisplayName() />
		<cfset ReturnData.data.accountCreationDate = CurrentUser.getDateCreated() />
		<cfset ReturnData.data.timesLoggedIn = CurrentUser.getTimesLoggedIn() />
		<cfset ReturnData.data.browserLastUsed = UserAgentStringForView />

		<cfreturn ReturnData />
	</cffunction>

	<cffunction name="changeUserSettings" access="public" returntype="struct" returnformat="JSON" output="false" hint="" >
		<cfargument name="NewDisplayName" type="string" required="true" hint="" />
		<cfargument name="NewUserName" type="string" required="true" hint="" />

		<cfset var ReturnData = {
			status: "",
			message: "",
			data: ""
		} />

		<cfset var ChangesMade = false />

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

		<cfset ReturnData.status = "OK" />
		<cfreturn ReturnData />
	</cffunction>

</cfcomponent>