<cfcomponent output="false">
<cfprocessingdirective pageencoding="utf-8" />

	<cfset THIS.name="RecipeDB">
	<cfset THIS.applicationtimeout = CreateTimeSpan(0,0,1,0)>
<!---	<cfset THIS.clientmanagement = false>
	<cfset THIS.setclientcookies = false>
	<cfset THIS.setdomaincookies = false>
	<cfset THIS.sessionmanagement = false>
	<cfset THIS.sessiontimeout = CreateTimeSpan(0,0,1,0)>
	<cfset THIS.loginstorage = "cookie">
	<cfset THIS.invokeImplicitAccessor = true /> --->

	<!--- MAPPINGS --->

	<cfset this.root = getDirectoryFromPath( getCurrentTemplatePath() ) />
	<cfset this.mappings["/Models"] = (this.root & "Components/") />
	<cfset this.mappings["/Assets"] = (this.root & "Assets/") />
	<cfset this.mappings["/Views"] = (this.root & "Views/") />
	<cfset this.mappings["/Controllers"] = (this.root & "Controllers/") />
	<cfset this.mappings["/Modules"] = (this.root & "Modules/") />

	<cffunction name="onApplicationStart" returnType="boolean" output="false">

		<!--- <cfset createObject("Component", "Objects/Server").init() /> --->

		<cfreturn true />

	</cffunction>

	<cffunction name="onRequestStart" returnType="boolean" output="false">

		<cfreturn true />
	</cffunction>

	<cffunction name="onRequestEnd" returntype="boolean" output="false">
		
		<cfreturn true />
	</cffunction>

</cfcomponent>