<cfcomponent output="false">
<cfprocessingdirective pageencoding="utf-8" />

	<cfset this.name="RecipeDB" />
	<cfset this.applicationtimeout = CreateTimeSpan(0,1,0,0) />
	<cfset this.sessionmanagement = true />
	<cfset this.sessiontimeout = CreateTimeSpan(0,0,30,0) />
	<cfset this.loginstorage = "session" />

	<!--- MAPPINGS --->

	<cfset this.root = getDirectoryFromPath( getCurrentTemplatePath() ) />
	<cfset this.loginDirectory = ListDeleteAt(this.root, ListLen(this.root, "\"), "\") />

	<cfset this.mappings["/Login"] = this.loginDirectory & "/" />
	<cfset this.mappings["/Models"] = (this.root & "Components/") />
	<cfset this.mappings["/Assets"] = (this.root & "Assets/") />
	<cfset this.mappings["/Views"] = (this.root & "Views/") />
	<cfset this.mappings["/Controllers"] = (this.root & "Controllers/") />
	<cfset this.mappings["/Modules"] = (this.root & "Modules/") />

	<cffunction name="onApplicationStart" returnType="boolean" output="false">
		<cfset application.Settings.Datasource = "dev" />

		<cfreturn true />
	</cffunction>

	<cffunction name="onRequestStart" returnType="boolean" output="true">
		<cfargument name="targetPage" type="string" required=true />

		<cfif isUserLoggedIn() IS false >
			<cfset createObject("component", "Login.LoginController").doLogout(
				Reason=1
			) />
		</cfif>
 		
		<cfreturn true />
	</cffunction>

	<cffunction name="onRequestEnd" returntype="boolean" output="false">
		
		<cfreturn true />
	</cffunction>

	<cffunction name="onSessionStart" returntype="boolean" output="false">
		
		<cfreturn true />
	</cffunction>

	<cffunction name="onSessionEnd" returntype="boolean" output="false">
		<cfloop collection="#session#" index="CurrentSessionScopeKey" >
			<cfset structDelete(session, CurrentSessionScopeKey) />
		</cfloop>

		<cfreturn true />
	</cffunction>

</cfcomponent>