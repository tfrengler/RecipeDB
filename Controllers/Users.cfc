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
			Datasource="dev"
		) />

		<cfif UserID GT 0 >
			<cfset User = createObject("component", "Models.User").init(
				ID=UserID,
				Datasource="dev"
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

		<cflogin applicationtoken="RecipeDB" idletimeout="1800" >
			<cfloginuser name="#User.getUserName()#" password="#User.getPassword()#" roles="User" >
		</cflogin>

		<cfset Session.User = User />

		<cfset ReturnData.Result = true />
		<cfreturn ReturnData />
	</cffunction>

	<cffunction name="doLogout" access="public" returntype="boolean" output="false" hint="" >
		<cfargument name="Reason" type="numeric" required="false" default="0" hint="The reason for hitting this function. 1 being session timeout or not logged in. 2 being user manually logged out" />

		<cflogout>

		<cfloop collection="#session#" index="CurrentSessionScopeKey" >
			<cfset structDelete(session, CurrentSessionScopeKey) />
		</cfloop>

		<cflocation url="Login.cfm?Reason=#arguments.Reason#" addtoken="false" />

		<cfreturn true />
	</cffunction>

</cfcomponent>