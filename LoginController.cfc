<cfcomponent output="false" >
<cfprocessingdirective pageEncoding="utf-8" />

	<cffunction name="attemptLogin" access="remote" returntype="struct" returnformat="JSON" output="false" hint="" >
		<cfargument name="Username" type="string" required="true" hint="" />
		<cfargument name="Password" type="string" required="true" hint="" />

		<cfset var Security = createObject("component", "Models.SecurityManager") />
		<cfset var StaticUser = createObject("component", "Models.User") />
		<cfset var UserID = 0 />
		<cfset var User = "" />
		<cfset var ReturnData = {
			Result: false,
			Code: 0
		} />

		<cfset UserID = StaticUser.getByUsername( 
			Username=trim(arguments.Username),
			Datasource="#application.Settings.Datasource#"
		) />

		<cfif UserID GT 0 >
			<cfset User = createObject("component", "Models.User").init(
				ID=UserID,
				Datasource="#application.Settings.Datasource#"
			) />
		<cfelse>
			<cfset ReturnData.Code = 1 />
			<cfreturn ReturnData />
			<!--- User name does not exist/is incorrect ---> 
		</cfif>

		<cfif User.validatePassword( Password=arguments.Password, SecurityManager=Security ) IS false >
			<cfset ReturnData.Code = 2 />
			<cfreturn ReturnData />
			<!--- Password is incorrect ---> 
		</cfif>

		<cfif User.getBlocked() IS 1 >
			<cfset ReturnData.Code = 3 />
			<cfreturn ReturnData />
			 <!--- User account is blocked ---> 
		</cfif>

		<cflogin applicationtoken="RecipeDB" idletimeout="1800" >
			<cfloginuser name="#User.getUserName()#" password="#User.getPassword()#" roles="User" />
		</cflogin>

		<cfset User.updateLoginStats(
			UserAgentString=cgi.http_user_agent
		) />
		<cfset User.save() />

		<cflock timeout="30" scope="Session" throwontimeout="true" >
			<cfset session.CurrentUser = User />
		</cflock>

		<cfset ReturnData.Result = true />
		<cfreturn ReturnData />
	</cffunction>

	<cffunction name="doLogout" access="remote" returntype="struct" returnformat="JSON" output="true" hint="" >
		<cfargument name="Reason" type="numeric" required="false" default="0" hint="The reason for logging out. 1 :session not existing. 2 :user manually logged out, and 3 :user is blocked." />

		<cfset var ReturnData = {
			Result: true,
			Code: javacast("int", arguments.Reason)
		} />

		<cflogout>

		<cfif arguments.Reason IS 1 >
			<cfoutput>
			<script>
			<!--- This feels dirty and dumb, but the cflocation does not work for requests coming through AJAX calls to CFC methods which expect HTML in return, grrrr --->
				window.location.replace("../../Login.cfm?Reason=#arguments.Reason#"); 
			<!--- <cflocation url="../../Login.cfm?Reason=#arguments.Reason#" addtoken="false" /> --->
			</script>
			</cfoutput>
		</cfif>

		<cfreturn ReturnData />
	</cffunction>
</cfcomponent>