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

	<cffunction name="onApplicationStart" returnType="boolean" output="false">

		<cfset application.Settings.Datasource = "dev" />

		<!--- <cfset application.securityManager = createObject("component", "Components.SecurityManager") />
		<cfset application.system = createObject("component", "Components.System") /> --->

		<cfreturn true />
	</cffunction>

	<cffunction name="onSessionStart" returntype="boolean" output="false">
		<!--- <cfset session.ajaxProxy = createObject("component", "Components.AjaxProxy") /> --->
		<cfreturn true />
	</cffunction>

	<cffunction name="onRequestStart" returnType="boolean" output="true" >

		<cfif isUserLoggedIn() IS false >
			<cfset createObject("component", "Login.AuthenticationManager").forceLogout() />
			<cfreturn false />
		</cfif>
 		
		<cfreturn true />
	</cffunction>

	<cffunction name="onSessionEnd" returntype="boolean" output="false">
		<cfset createObject("component", "Login.AuthenticationManager").clearSession() />
		<cfreturn true />
	</cffunction>
</cfcomponent>