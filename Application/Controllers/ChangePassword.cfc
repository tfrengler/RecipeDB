<cfcomponent output="false" >
<cfprocessingdirective pageEncoding="utf-8" />

	<!--- AJAX METHOD --->
	<cffunction name="main" access="public" returntype="struct" returnformat="JSON" output="false" hint="" >
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