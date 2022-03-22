<cfcomponent output="false" hint="" >

	<!---
		AJAX error handling revolves around status codes. Anything that doesn't go according to plan,
		either programmatically or control wise, returns 50X and triggers jQuery's onError(), which is
		what we react to solely on the front end (as far as AJAX goes that is)
	--->

	<cffunction name="call" returntype="struct" access="remote" returnformat="JSON" output="false" hint="Acts as a interface for frontend Javascript via ajax to call backend CFC methods, passing along argument data as well." >
		<cfargument name="controller" type="string" required="true" hint="The name of the CFC you want to call." />
		<cfargument name="method" type="string" required="false" default="main" hint="" />
		<cfargument name="parameters" type="struct" required="false" default="#{}#" hint="A structure of key/value pairs of arguments to the method you're calling." />
		<cfargument name="authKey" type="string" required="true" hint="A unique hash (512) key that is checked against an internal validator. This exists to prevent people from using this proxy remotely without authorization." />
		<cfscript>

		if (arguments.controller.len() == 0)
			return new Models.ControllerData(101);

		if (arguments.method.len() == 0)
			return new Models.ControllerData(102);

		if (session.authKey != arguments.authKey)
			return new Models.ControllerData(103);

		if (listFind(application.allowedAJAXControllers, "#trim(arguments.controller)#.cfc") IS 0)
			return new Models.ControllerData(104);

		try {
			return invoke("Controllers.#arguments.Controller#", arguments.method, arguments.Parameters);
		}
		catch (any error) {
			return new Models.ControllerData(105);
		}

		</cfscript>
	</cffunction>
</cfcomponent>