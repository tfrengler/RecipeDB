<cfcomponent output="false" hint="" >
<cfprocessingdirective pageencoding="utf-8" />

	<cffunction name="call" returntype="struct" access="remote" returnformat="JSON" hint="Acts as a interface for frontend Javascript via ajax to call backend CFC methods, passing along argument data as well." >
		<cfargument name="Component" type="string" required="true" hint="The name of the CFC you want to call." />
		<cfargument name="Function" type="string" required="true" hint="The name of the CFC method you want to call." />
		<cfargument name="Parameters" type="struct" required="true" hint="A structure of key/value pairs of arguments to the method you're calling." />
		<cfargument name="AuthKey" type="string" required="true" hint="A unique hash (512) key that is checked against an internal validator. This exists to prevent people from using this proxy remotely without authorization." />

		<cfif len(arguments.Component) IS 0 >

			<cfheader statuscode="500" />
			<cfset stReturnData.status = "NOK" />
			<cfset stReturnData.message = "Argument 'Component' is empty" />
			<cfreturn stReturnData />

		</cfif>

		<cfif len(arguments.Function) IS 0 >

			<cfheader statuscode="500" />
			<cfset stReturnData.status = "NOK" />
			<cfset stReturnData.message = "Argument 'Function' is empty" />
			<cfreturn stReturnData />

		</cfif>

		<cfif session.CurrentUser.getAuthKey() IS NOT arguments.AuthKey >

			<cfheader statuscode="500" />
			<cfset stReturnData.status = "NOK" />
			<cfset stReturnData.message = "Not authorized for this action" />
			<cfreturn stReturnData />

		</cfif>

		<cfreturn invoke("Controllers.#arguments.Component#", arguments.Function, arguments.Parameters) />
	</cffunction>

</cfcomponent>