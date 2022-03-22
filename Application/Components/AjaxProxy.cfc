<cfcomponent output="false" hint="" >

	<!---
		AJAX error handling revolves around status codes. Anything that doesn't go according to plan,
		either programmatically or control wise, returns 50X and triggers jQuery's onError(), which is
		what we react to solely on the front end (as far as AJAX goes that is)
	--->

	<cffunction name="call" returntype="struct" access="remote" returnformat="JSON" output="false" hint="Acts as a interface for frontend Javascript via ajax to call backend CFC methods, passing along argument data as well." >
		<cfargument name="Controller" type="string" required="true" hint="The name of the CFC you want to call." />
		<cfargument name="Parameters" type="struct" required="false" default="#structNew()#" hint="A structure of key/value pairs of arguments to the method you're calling." />
		<cfargument name="AuthKey" type="string" required="true" hint="A unique hash (512) key that is checked against an internal validator. This exists to prevent people from using this proxy remotely without authorization." />

		<cfset var returnData = {
			statuscode: 0,
			data: ""
		} />

		<cfif len(arguments.Controller) IS 0 >

			<cfset returnData.statuscode = 101 />
			<cfreturn returnData />

		</cfif>

		<cfif session.AuthKey IS NOT arguments.AuthKey >

			<cfset returnData.statuscode = 102 />
			<cfreturn returnData />

		</cfif>

		<cfif listFind(application.allowedAJAXControllers, "#trim(arguments.Controller)#.cfc") IS 0 >

			<cfset returnData.statuscode = 103 />
			<cfreturn returnData />

		<cfelse>
			<cfreturn invoke("Controllers.#arguments.Controller#", "main", arguments.Parameters) />
		</cfif>
	</cffunction>

</cfcomponent>