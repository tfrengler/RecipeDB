<cfcomponent output="false" >
<cfprocessingdirective pageEncoding="utf-8" />

	<!--- AJAX METHOD --->
	<cffunction name="main" access="public" returntype="struct" returnformat="JSON" output="false" hint="" >
		<cfargument name="recipeID" type="numeric" required="true" />

		<cfset var returnData = {
 			statuscode: 0,
 			data: ""
 		} />

		<cfset var Recipe = createObject("component", "Models.Recipe").init( 
			ID=arguments.recipeID,
			Datasource=application.Settings.Datasource
		) />

		<cfset Recipe.delete() />

		<cfreturn returnData />
	</cffunction>

</cfcomponent>