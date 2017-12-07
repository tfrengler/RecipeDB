<cfcomponent output="false" hint="" >
<cfprocessingdirective pageencoding="utf-8" />

	<!--- 
		AJAX error handling revolves around status codes. Anything that doesn't go according to plan, 
		either programmatically or control wise, returns 50X and triggers jQuery's onError(), which is
		what we react to solely on the front end (as far as AJAX goes that is)
	--->

	<cfset allowedComponents = "Communication,Recipes,Users" />

	<cffunction name="call" returntype="struct" access="remote" returnformat="JSON" hint="Acts as a interface for frontend Javascript via ajax to call backend CFC methods, passing along argument data as well." >
		<cfargument name="Component" type="string" required="true" hint="The name of the CFC you want to call." />
		<cfargument name="Function" type="string" required="true" hint="The name of the CFC method you want to call." />
		<cfargument name="Parameters" type="struct" required="false" default="#structNew()#" hint="A structure of key/value pairs of arguments to the method you're calling." />
		<cfargument name="AuthKey" type="string" required="true" hint="A unique hash (512) key that is checked against an internal validator. This exists to prevent people from using this proxy remotely without authorization." />

		<cfset var returnData = {
 			statuscode: 0,
 			data: ""
 		} />

		<cfif len(arguments.Component) IS 0 >

			<cfset returnData.statuscode = 1 />
			<cfreturn returnData />

		</cfif>

		<cfif len(arguments.Function) IS 0 >

			<cfset returnData.statuscode = 2 />
			<cfreturn returnData />

		</cfif>

		<cfif session.AuthKey IS NOT arguments.AuthKey >

			<cfset returnData.statuscode = 3 />
			<cfreturn returnData />

		</cfif>

		<cfif listFind(variables.allowedComponents, trim(arguments.Component)) IS 0 >

			<cfset returnData.statuscode = 4 />
			<cfreturn returnData />

		<cfelse>
			<cfreturn invoke("Controllers.#arguments.Component#", arguments.Function, arguments.Parameters) />
		</cfif>
	</cffunction>

</cfcomponent>