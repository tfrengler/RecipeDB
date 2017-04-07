<cfcomponent output="false">
<cfprocessingdirective pageencoding="utf-8" />

	<cfset this.name="RecipeDB" />
	<cfset this.applicationtimeout = CreateTimeSpan(0,1,0,0) />
	<cfset this.sessionmanagement = true />
	<cfset this.sessiontimeout = CreateTimeSpan(0,0,30,0) />
	<cfset this.loginstorage = "session" />

	<!--- MAPPINGS --->

	<cfset this.root = getDirectoryFromPath( getCurrentTemplatePath() ) />
	<cfset this.appdirectory = this.root & "Application\" /> 
	
	<cfset this.mappings["/Models"] = (this.appdirectory & "Components/") />
	<cfset this.mappings["/Assets"] = (this.appdirectory & "Assets/") />
	<cfset this.mappings["/Views"] = (this.appdirectory & "Views/") />
	<cfset this.mappings["/Controllers"] = (this.appdirectory & "Controllers/") />
	<cfset this.mappings["/Modules"] = (this.appdirectory & "Modules/") />

	<cffunction name="onApplicationStart" returnType="boolean" output="false">
		<cfset application.Settings.Datasource = "dev" />

		<cfreturn true />
	</cffunction>

	<cffunction name="onRequestStart" returnType="boolean" output="true">

		<cfreturn true />
	</cffunction>

	<cffunction name="onRequestEnd" returntype="boolean" output="false">
		
		<cfreturn true />
	</cffunction>

	<cffunction name="onSessionEnd" returntype="boolean" output="false">
		<cfloop collection="#session#" index="CurrentSessionScopeKey" >
			<cfset structDelete(session, CurrentSessionScopeKey) />
		</cfloop>

		<cfreturn true />
	</cffunction>
</cfcomponent>