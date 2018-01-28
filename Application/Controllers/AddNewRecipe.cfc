<cfcomponent output="false" >
<cfprocessingdirective pageEncoding="utf-8" />

	<!--- AJAX METHOD --->
	<cffunction name="main" access="public" returntype="struct" returnformat="JSON" output="false" hint="" >
		<cfargument name="Name" type="string" required="true" />

		<cfset var returnData = {
 			statuscode: 0,
 			data: 0
 		} />

		<cfif len(arguments.Name) IS 0 >

			<cfheader statuscode="500" />
			<cfset returnData.statuscode = 1 />
			<cfreturn returnData />

		</cfif>

		<cfset var recipeInterface = createObject("component", "Models.Recipe") />
		<cfset var newRecipe = "" />

		<cfset NewRecipe = RecipeInterface.create(
			UserID=session.CurrentUser.getID(),
			Name=trim(arguments.Name),
			Datasource=application.settings.datasource
		 ) />

		<cfset returnData.data = NewRecipe.getID() />

		<cfreturn returnData />
	</cffunction>

</cfcomponent>