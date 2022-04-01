<cfcomponent output="false">

	<cfset this.name="RecipeDB" />
	<cfset this.applicationtimeout = CreateTimeSpan(14,0,0,0) />

	<cfset this.sessionmanagement = true />
	<cfset this.setClientCookies = true />
	<cfset this.sessioncookie.secure = true />
	<cfset this.sessiontimeout = CreateTimeSpan(0,1,0,0) />
	<cfset this.sessionType = "cfml" />
	<cfset this.loginstorage = "session" />

	<cfset this.scriptProtect = "all" />
	<cfset this.invokeImplicitAccessor = true />

	<!--- MAPPINGS --->

	<cfset this.root = getDirectoryFromPath( getCurrentTemplatePath() ) />
	<cfset this.appdirectory = this.root & "Application/" />

	<cfset this.mappings["/Models"] = (this.appdirectory & "Models/") />
	<cfset this.mappings["/Components"] = (this.appdirectory & "Components/") />
	<cfset this.mappings["/Assets"] = (this.appdirectory & "Assets/") />
	<cfset this.mappings["/Views"] = (this.appdirectory & "Views/") />
	<cfset this.mappings["/Controllers"] = (this.appdirectory & "Controllers/") />

	<cfset this.defaultdatasource = {
		class: "org.sqlite.JDBC",
		connectionString: "jdbc:sqlite:#this.root#dfa8c46a-29b3-4a1f-947e-0bdd385380bb/RecipeDB.sdb",
		timezone: "CET",
		custom: {useUnicode: true, characterEncoding: 'UTF-8', Version: 3},
		blob: true,
		clob: true,
		validate: true
	} />

	<cffunction name="onApplicationStart" returnType="boolean" output="false">

		<cftry>
			<cfquery>PRAGMA foreign_keys = ON;</cfquery>

		<cfcatch type="lucee.runtime.exp.NativeException">

			<cfset var DbLibFile = "#this.Root#\Toolbox\sqlite-jdbc-3.36.0.3.jar" /> <!--- https://github.com/xerial/sqlite-jdbc --->
			<cfset var CFMLEngine = createObject( "java", "lucee.loader.engine.CFMLEngineFactory" ).getInstance() />
			<cfset var OSGiUtil = createObject( "java", "lucee.runtime.osgi.OSGiUtil" ) />
			<cfset var Resource = CFMLEngine.getResourceUtil().toResourceExisting( getPageContext(), DbLibFile ) />

			<cfset OSGiUtil.installBundle(
				CFMLEngine.getBundleContext(),
				Resource,
				true
			) />

		</cfcatch>
		</cftry>

		<cfset application.cookieName = '__tracker_ad_token' />
		<cfset var queryListOfControllers = null />
		<cfset application.allowedAJAXControllers = null />

		<!--- Set up singletons --->
		<cfif NOT structKeyExists(application, "securityManager") >
			<cfset application.SecurityManager = new Components.SecurityManager() />
		</cfif>

		<!--- SETTING UP ALLOWED AJAX PROXY CFC TARGETS --->
		<cfdirectory directory="/Controllers" action="list" filter="*.cfc" type="file" listinfo="name" name="queryListOfControllers" >

		<cfloop query=#queryListOfControllers# >
			<cfset application.AllowedAJAXControllers = listAppend(application.allowedAJAXControllers, queryListOfControllers.name) />
		</cfloop>

		<cfreturn true />
	</cffunction>

	<cffunction name="onRequestStart" returnType="boolean" output="false" >
		<cfargument type="string" name="targetPage" required="true" />

		<cfset var BaseURI = "http#cgi.SERVER_PORT_SECURE ? "s" : ""#://#cgi.SERVER_NAME#/RecipeDB" />

		<!--- For testing purposes, this nukes the session and restarts the application --->
		<cfif structKeyExists(URL, "Restart") >

			<cfset onSessionEnd(session, application) />
			<cfset applicationStop() />
			<cflocation url="#BaseURI#/Login.cfm" addtoken="false" />

		</cfif>

		<!---
			LOGIN FAIL REASONS:
			1: User name does not exist/is incorrect
			2: There's more than one record with this username
			3: Password is incorrect
			4: User account is blocked
			5: Invalid session or session expired
			6: Password and username not in form-scope
			7: You have been logged out
		--->

		<!--- Hitting the logout page? Fine, we log you out and and your session --->
		<cfif find("/Logout.cfm", arguments.targetPage) >
			<cfset onSessionEnd(session, application) />
			<cflogout />
			<cfreturn true />
		</cfif>

		<!---
			Targeting the login page without passing form-values and the Toolbox gives you safe passage
			Targeting anything but the Toolbox (index or Login) logs you out if you were logged in
		--->
		<cfif
			(find("/Login.cfm", arguments.targetPage) AND structIsEmpty(form)) OR
			find("/RecipeDB/index.cfm", arguments.targetPage) OR
			find("/Toolbox/", arguments.targetPage)
		>

			<cfif NOT find("/Toolbox/", arguments.targetPage) AND isUserLoggedIn() >
				<cfset onSessionEnd(session, application) />
				<cflogout />
			</cfif>

			<cfreturn true />
		</cfif>

		<!--- Targeting the login page and the FORM-scope has values? Probably a login attempt --->
		<cfif find("/Login.cfm", arguments.targetPage) AND NOT structIsEmpty(form) >
			<!--- No username and password in form? Bye! --->
			<cfif NOT structKeyExists(form, "username") OR NOT structKeyExists(form, "password") >
				<cfset application.SecurityManager.NewSession(session) />
				<cflocation url="#BaseURI#/Login.cfm?Reason=6" addtoken="false" />
			</cfif>

			<cfset var LoginTryResult = application.SecurityManager.TryLogIn(form.username, form.password, session) />
			<!--- Login attempt failed (for whatever reason)? Bye! --->
			<cfif LoginTryResult IS NOT 0 >
				<cfset application.SecurityManager.NewSession(session) />
				<cflocation url="#BaseURI#/Login.cfm?Reason=#LoginTryResult#" addtoken="false" />
			</cfif>

			<!--- Everything okay? You're logged in! Redirect to the main app --->
			<cflocation url="#BaseURI#/Application/index.cfm" addtoken="false" />
		</cfif>

		<cfif NOT application.SecurityManager.IsValidSession(cookie, session) >
			<cfset application.SecurityManager.NewSession(session) />
			<cflocation url="#BaseURI#/Login.cfm?Reason=5&t=1" addtoken="false" />
		</cfif>

		<cfif NOT isUserLoggedIn() >
			<cfset application.SecurityManager.NewSession(session) />
			<cflocation url="#BaseURI#/Login.cfm?Reason=5&t=2" addtoken="false" />
		</cfif>

		<cfreturn true />
	</cffunction>

	<cffunction name="onSessionEnd" returntype="void" output="false">
		<cfargument name="sessionScope" type="struct" required="true" />
		<cfargument name="applicationScope" type="struct" required="true" />

		<cfset var SessionToken = structKeyExists(arguments.sessionScope, "SessionToken") ? arguments.sessionScope.SessionToken : "NIL" />
		<cfset application.SecurityManager.SetSessionCookie(SessionToken, true) />
		<cfset sessionInvalidate() />
	</cffunction>

</cfcomponent>