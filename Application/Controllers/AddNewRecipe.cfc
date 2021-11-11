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

		<cfset var NewRecipe = Models.Recipe::Create(
			UserID=session.CurrentUser.GetUserID(),
			Name=trim(arguments.Name)
		) />

		<cfset returnData.data = NewRecipe.GetRecipeID() />

		<cfreturn returnData />
	</cffunction>

</cfcomponent>