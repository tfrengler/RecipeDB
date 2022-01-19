<cfcomponent output="false" >

	<!--- AJAX METHOD --->
	<cffunction name="main" access="public" returntype="struct" returnformat="JSON" output="false" hint="" >
		<cfargument name="RecipeID" type="numeric" required="true" />
		<cfargument name="UpdateData" type="struct" required="true" />

		<cfset var returnData = {
			statuscode: 0,
			data: ""
		} />

		<cfif arguments.RecipeID LTE 0 >

			<cfheader statuscode="500" />
			<cfset returnData.statuscode = 1 />
			<cfreturn returnData />

		</cfif>

		<cfset var Recipe = new Models.Recipe(arguments.RecipeID) />

		<cfif Recipe.GetCreatedByUser().GetUserID() IS NOT session.currentUser.GetUserID() >

			<cfheader statuscode="500" />
			<cfset returnData.statuscode = 2 />
			<cfreturn returnData />

		</cfif>

		<cfset Recipe.SetIngredients(arguments.UpdateData.ingredients) />
		<cfset Recipe.SetDescription(arguments.UpdateData.description) />
		<cfset Recipe.SetInstructions(arguments.UpdateData.instructions) />
		<cfset Recipe.SetName(arguments.UpdateData.name) />

		<cfset Recipe.save(session.currentUser.GetUserID()) />
		<cfset returnData.data = Components.Localizer::GetDisplayDateTime(Recipe.GetDateTimeLastModified()) />

		<cfreturn returnData />
	</cffunction>

</cfcomponent>