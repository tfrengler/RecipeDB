<cfcomponent output="false" >

	<!--- AJAX METHOD --->
	<cffunction name="main" access="public" returntype="struct" returnformat="JSON" output="false" hint="" >
		<cfargument name="recipeID" type="numeric" required="true" />

		<cfset var returnData = {
			statuscode: 0,
			data: ""
		} />

		<cfset var Recipe = new Models.Recipe(arguments.recipeID) />

		<cfif Recipe.GetCreatedByUser().GetUserID() IS NOT session.currentUser.GetUserID() >

			<cfheader statuscode="500" />
			<cfset returnData.statuscode = 1 />
			<cfreturn returnData />

		</cfif>

		<cfset Recipe.Delete() />
		<cfreturn returnData />
	</cffunction>

</cfcomponent>