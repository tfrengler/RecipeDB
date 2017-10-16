<cfcomponent output="false">
<cfprocessingdirective pageencoding="utf-8" />

	<cfset this.name="RecipeDB" />
	<cfset this.applicationtimeout = CreateTimeSpan(1,0,0,0) />
	<cfset this.sessionmanagement = true />
	<cfset this.sessiontimeout = CreateTimeSpan(0,0,35,0) />
	<cfset this.loginstorage = "session" />
	<cfset this.setClientCookies = true />
	<cfset this.scriptProtect = "all" />

	<!--- MAPPINGS --->

	<cfset this.root = getDirectoryFromPath( getCurrentTemplatePath() ) />
	<cfset this.loginDirectory = ListDeleteAt(this.root, ListLen(this.root, "\"), "\") />

	<cfset this.mappings["/Login"] = this.loginDirectory & "/" />
	<cfset this.mappings["/Models"] = (this.root & "Models/") />
	<cfset this.mappings["/Components"] = (this.root & "Components/") />
	<cfset this.mappings["/Assets"] = (this.root & "Assets/") />
	<cfset this.mappings["/Views"] = (this.root & "Views/") />
	<cfset this.mappings["/Controllers"] = (this.root & "Controllers/") />
	<cfset this.mappings["/Modules"] = (this.root & "Modules/") />
	<cfset this.mappings["/PatchNotes"] = (this.loginDirectory & "/Notes/Patch/") />
	<cfset this.mappings["/Roadmap"] = (this.loginDirectory & "/Notes/Roadmap/") />

	<cffunction name="onApplicationStart" returnType="boolean" output="false">

		<cfset application.settings.datasource = "dev" />

		<cfif structKeyExists(application, "securityManager") IS false >
			<cfset application.securityManager = createObject("component", "Components.SecurityManager") />
		</cfif>
		<!--- <cfif structKeyExists(application, "ajaxProxy") IS false >
			<cfset application.ajaxProxy = createObject("component", "Components.AjaxProxy") />
		</cfif> --->
		<cfif structKeyExists(application, "authenticationManager") IS false >
			<cfset application.authenticationManager = createObject("component", "Login.AuthenticationManager") />
		</cfif>

		<cfreturn true />
	</cffunction>

	<cffunction name="onSessionStart" returntype="boolean" output="false">
		<cfreturn true />
	</cffunction>

	<cffunction name="onRequestStart" returnType="boolean" output="true" >

		<cfif structKeyExists(url, "Restart") >

			<cfset sessionInvalidate() />
			<cfset applicationStop() />
			<cflocation url="Main.cfm" addtoken="false" />

		</cfif>

		<cfif isUserLoggedIn() IS false >
			<cfset createObject("component", "Login.AuthenticationManager").forceLogout() />
			<cfreturn false />
		</cfif>
		
		<cfreturn true />
	</cffunction>

	<cffunction name="onSessionEnd" returntype="boolean" output="false">

		<cfcookie name="CFID" value="" expires="NOW" />
		<cfcookie name="CFTOKEN" value="" expires="NOW" />

		<cfreturn true />

	</cffunction>

	<!--- <cffunction name="onCFCRequest" returnType="void"> 
		<cfargument type="string" name="cfcname" required="false" />
		<cfargument type="string" name="method" required="false" />
		<cfargument type="struct" name="args" required="false" />

		<cfreturn "404" />
	</cffunction> --->
</cfcomponent>