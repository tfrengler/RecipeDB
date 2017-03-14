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
	<cfset THIS.ormenabled = true />
	<cfset THIS.ormsettings = {
		datasource="peoplexs_test",
		searchenabled = true
	} />
	<cfset THIS.invokeImplicitAccessor = true /> --->

	<!--- MAPPINGS --->

	<cfset this.root = getDirectoryFromPath( getCurrentTemplatePath() ) />
	<cfset this.mappings["/Objects"] = (this.root & "Components/") />

	<cffunction name="onApplicationStart" returnType="boolean" output="false">

		<!--- <cfset createObject("Component", "Objects/Server").init() /> --->

		<cfreturn true />

	</cffunction>

	<cffunction name="onRequestStart" returnType="boolean" output="false">

		<cfreturn true />
	</cffunction>

	<cffunction name="onRequestEnd" returntype="boolean" output="false">
		
		<!--- <cflocation url="Reset.cfm" /> --->
		<cfreturn true />
	</cffunction>

</cfcomponent>

<!--- http://www.briankotek.com/blog/index.cfm/2010/9/14/Using-ColdFusion-ORM-and-HQL-Part-3-Bidirectional-Relationships --->
<!--- http://www.barneyb.com/barneyblog/2010/04/09/dont-forget-inverse-true/ --->

<!--- 	NOTE ON RELATIONSHIPS:

	You need a cfproperty in both CFCs and these are used to reference each other (bi-directional relationship). Uni-directional you just need it in the CFC that wants to join with the other CFC.

	With one-to-one relationship the "fkcolumn"-attribute corresponds to the foreignkey in -this- CFC, that maps to the primarykey in the referenced CFC.
	The property in the referenced CFC has to have "mappedby" set instead of fkcolumn and it must point back to the original cfproperty in -this- CFC.

	With one-to-many OR many-to-many relationship the "fkcolumn" in this CFC corresponds to the foreignkey in the -referenced- CFC, which is in turn the primary key of this CFC.
	The property in the referenced CFC does not need to have "mappedby" or "fkcolumn" set at all!

	inverse=true has to be set in either CFC otherwise when saving the entity data is not persisted correctly! Inverse should be set on the one-side in a "one-to-many" relationship
 --->