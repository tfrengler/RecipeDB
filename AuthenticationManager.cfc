<cfcomponent output="false" >
<cfprocessingdirective pageEncoding="utf-8" />

	<cffunction name="attemptLogin" access="remote" returntype="struct" returnformat="JSON" output="false" hint="" >
		<cfargument name="Username" type="string" required="true" hint="" />
		<cfargument name="Password" type="string" required="true" hint="" />

		<cfset var UserInterface = createObject("component", "Models.User") />
		<cfset var UserID = 0 />
		<cfset var UserSearch = queryNew(1) />
		<cfset var User = "" />

		<cfset var ReturnData = {
			Result: false,
			Code: 0
		} />

		<cfset UserSearch = UserInterface.getBy( 
			ColumnToSearchOn="UserName",
			SearchOperator="equal to",
			SearchData=trim(arguments.Username),
			Datasource="#application.Settings.Datasource#"
		) />

		<cfif UserSearch.RecordCount IS 1 >
			<cfset User = createObject("component", "Models.User").init(
				ID=UserSearch[ UserInterface.getTableKey() ],
				Datasource="#application.Settings.Datasource#"
			) />

		<cfelseif UserSearch.RecordCount IS 0 >
			<cfset ReturnData.Code = 1 />
			<cfreturn ReturnData />
			<!--- User name does not exist/is incorrect --->

		<cfelseif UserSearch.RecordCount GT 1 >
			<cfset ReturnData.Code = 4 />
			<cfreturn ReturnData />
			<!--- There's more than one record with this username --->

		</cfif>

		<cfif User.validatePassword( Password=arguments.Password, SecurityManager=application.securityManager ) IS false >
			<cfset ReturnData.Code = 2 />
			<cfreturn ReturnData />
			<!--- Password is incorrect ---> 
		</cfif>

		<cfif User.getBlocked() IS 1 >
			<cfset ReturnData.Code = 3 />
			<cfreturn ReturnData />
			 <!--- User account is blocked ---> 
		</cfif>

		<cflogout>

		<cflogin applicationtoken="RecipeDB" idletimeout="1800" >
			<cfloginuser name="#User.getUserName()#" password="#User.getPassword()#" roles="User" />
		</cflogin>

		<cfset User.updateLoginStats(
			UserAgentString=cgi.http_user_agent
		) />
		<cfset User.save() />

		<cflock timeout="30" scope="Session" throwontimeout="true" >
			<cfset session.currentUser = User />
			<cfset session.authKey = application.securityManager.generateAuthKey() />
		</cflock>

		<cfset ReturnData.Result = true />
		<cfreturn ReturnData />
	</cffunction>

	<cffunction name="gracefulLogout" access="remote" returntype="struct" returnformat="JSON" output="false" hint="" >
		<cfargument name="Reason" type="numeric" required="false" default="0" hint="The reason for logging out" />

		<cfset var ReturnData = {
			Result: true,
			Code: javacast("int", arguments.Reason)
		} />

		<cflogout>

		<cfreturn ReturnData />
	</cffunction>

	<cffunction name="forceLogout" access="remote" returntype="void" output="true" hint="" >
		<cflogout>

		<cfheader name="Content-Type" value="text/html;charset=UTF-8" />
		<script>
			window.location.replace("../../Login.cfm?Reason=1"); 
		</script>
	</cffunction>
</cfcomponent>