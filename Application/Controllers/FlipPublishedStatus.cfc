<cfcomponent output="false" >
<cfprocessingdirective pageEncoding="utf-8" />

	<!--- AJAX METHOD --->
	<cffunction name="main" access="public" returntype="struct" returnformat="JSON" output="false" hint="" >
		<cfargument name="RecipeID" type="numeric" required="true" />

		<cfset var returnData = {
 			statuscode: 0,
 			data: ""
 		} />

		<cfset var Recipe = createObject("component", "Models.Recipe").init( 
			ID=arguments.RecipeID,
			Datasource=application.Settings.Datasource
		) />

		<cfif Recipe.getPublished() IS false >
			<cfset Recipe.setPublished(status=true) />
			<cfset returnData.data = true />
		<cfelse>
			<cfset Recipe.setPublished(status=false) />
			<cfset returnData.data = false />
		</cfif>

		<cfset Recipe.save() />

		<cfreturn returnData />
	</cffunction>

</cfcomponent>