<cfcomponent output="false" >
<cfprocessingdirective pageEncoding="utf-8" />

	<cffunction name="main" access="public" returntype="struct" output="false" hint="" >
		<cfargument name="user" type="Models.User" required="true" hint="" />

		<cfset var returnData = {
 			statuscode: 0,
 			data: structNew()
 		} />

		<cfset var UserAgentStringResult = "" />
		<cfset var UserAgentStringForView = arguments.user.getBrowserLastUsed() />

		<cfif structKeyExists(session, "UserAgent") IS false >

			<cfhttp url="http://useragentstring.com/" method="post" timeout="2" throwonerror="false" result="UserAgentStringResult" >
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
				<cfset UserAgentStringForView = encodeForHTML(session.UserAgent.agent_name) />
			<cfelse>
				<cfset UserAgentStringForView = "Unknown browser" />
			</cfif>

			<cfif structKeyExists(session.UserAgent, "agent_version") AND len(session.UserAgent.agent_version) GT 0 >
				<cfset UserAgentStringForView = (UserAgentStringForView & " #encodeForHTML(session.UserAgent.agent_version)#") />
			<cfelse>
				<cfset UserAgentStringForView = (UserAgentStringForView & ", unknown version") />
			</cfif>

			<cfif structKeyExists(session.UserAgent, "os_name") AND len(session.UserAgent.os_name) GT 0 >
				<cfset UserAgentStringForView = (UserAgentStringForView & ", running on #encodeForHTML(session.UserAgent.os_name)#") />
			<cfelse>
				<cfset UserAgentStringForView = (UserAgentStringForView & ", running on an unknown OS") />
			</cfif>

		</cfif>

		<cfset returnData.data.username = arguments.user.getUsername() />
		<cfset returnData.data.displayName = arguments.user.getDisplayName() />
		<cfset returnData.data.accountCreationDate = arguments.user.getDateCreated() />
		<cfset returnData.data.timesLoggedIn = arguments.user.getTimesLoggedIn() />
		<cfset returnData.data.browserLastUsed = UserAgentStringForView />
		<cfset returnData.data.recipeListFilter = arguments.user.getSettings().findRecipes.filter />
		<cfset returnData.data.recipeListType = arguments.user.getSettings().findRecipes.listType />
		<cfset returnData.data.recipeListSortColumn = arguments.user.getSettings().findRecipes.sortOnColumn />

		<cfreturn returnData />
	</cffunction>

</cfcomponent>