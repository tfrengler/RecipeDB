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
	<cfset this.appdirectory = this.root & "Application\" /> 
	
	<cfset this.mappings["/Components"] = (this.appdirectory & "Components/") />
	<cfset this.mappings["/Models"] = (this.appdirectory & "Models/") />
	<cfset this.mappings["/Assets"] = (this.appdirectory & "Assets/") />
	<cfset this.mappings["/Views"] = (this.appdirectory & "Views/") />
	<cfset this.mappings["/Controllers"] = (this.appdirectory & "Controllers/") />
	<cfset this.mappings["/Modules"] = (this.appdirectory & "Modules/") />

	<cffunction name="onApplicationStart" returnType="boolean" output="false">

		<cfif structKeyExists(application, "securityManager") IS false >
			<cfset application.securityManager = createObject("component", "Components.SecurityManager") />
		</cfif>
		<!--- <cfif structKeyExists(application, "ajaxProxy") IS false >
			<cfset application.ajaxProxy = createObject("component", "Components.AjaxProxy") />
		</cfif> --->
		<cfif structKeyExists(application, "authenticationManager") IS false >
			<cfset application.authenticationManager = createObject("component", "AuthenticationManager") />
		</cfif>

		<cfset application.Settings.Datasource = "dev" />

		<cfreturn true />
	</cffunction>

	<cffunction name="onRequestStart" returnType="boolean" output="true" >

		<cfif structKeyExists(url, "Restart") >

			<cfset sessionInvalidate() />
			<cfset applicationStop() />
			<cflocation url="Login.cfm" addtoken="false" />

		</cfif>

		<cfreturn true />
	</cffunction>

	<cffunction name="onSessionEnd" returntype="boolean" output="false">

		<cfset sessionInvalidate() />
		<cfreturn true />
		
	</cffunction>
</cfcomponent>