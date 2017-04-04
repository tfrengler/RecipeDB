<cfcomponent output="false">
<cfprocessingdirective pageencoding="utf-8" />

	<cfset this.name="RecipeDB" />
	<cfset this.applicationtimeout = CreateTimeSpan(0,1,0,0) />
	<cfset this.sessionmanagement = true />
	<cfset this.sessiontimeout = CreateTimeSpan(0,0,30,0) />
	<cfset this.loginstorage = "session" />

	<!--- MAPPINGS --->

	<cfset this.root = getDirectoryFromPath( getCurrentTemplatePath() ) />
	<cfset this.mappings["/Models"] = (this.root & "Components/") />
	<cfset this.mappings["/Assets"] = (this.root & "Assets/") />
	<cfset this.mappings["/Views"] = (this.root & "Views/") />
	<cfset this.mappings["/Controllers"] = (this.root & "Controllers/") />
	<cfset this.mappings["/Modules"] = (this.root & "Modules/") />

	<cffunction name="onApplicationStart" returnType="boolean" output="false">

		<cfset this.Settings.Datasource = "dev" />

		<cfreturn true />
	</cffunction>

	<cffunction name="onRequestStart" returnType="boolean" output="true">
		<cfargument type="String" name="targetPage" required=true />

		<cfif find("Login.cfm", arguments.targetPage) IS 0 AND isUserLoggedIn() IS false >

			<cfset createObject("component", "Controllers.Users").doLogout(
				Reason=1
			) />
		</cfif>

		<cfreturn true />
	</cffunction>

	<cffunction name="onRequestEnd" returntype="boolean" output="false">
		
		<cfreturn true />
	</cffunction>

	<cffunction name="onSessionEnd" returntype="boolean" output="false">
		<cfset createObject("component", "Controllers.Users").doLogout() />
		<cfreturn true />
	</cffunction>

</cfcomponent>