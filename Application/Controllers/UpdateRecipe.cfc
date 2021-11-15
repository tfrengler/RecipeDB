<cfcomponent output="false" >
<cfprocessingdirective pageEncoding="utf-8" />

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

		<cfset var Recipe = createObject("component", "Models.Recipe").init(arguments.RecipeID) />

		<cfif Recipe.getCreatedByUser().getId() IS NOT session.currentUser.getId() >

			<cfheader statuscode="500" />
			<cfset returnData.statuscode = 2 />
			<cfreturn returnData />

		</cfif>

		<cfset Recipe.setIngredients(Data=arguments.UpdateData.ingredients) />
		<cfset Recipe.setDescription(Data=arguments.UpdateData.description) />
		<cfset Recipe.setInstructions(Data=arguments.UpdateData.instructions) />
		<cfset Recipe.setName(Data=arguments.UpdateData.name) />

		<cfset Recipe.setDateTimeLastModified(Date=createODBCdatetime(now())) />
		<cfset Recipe.setLastModifiedByUser(UserInstance=session.currentUser) />

		<cfset Recipe.save() />
		<cfset returnData.data = LSDateTimeFormat(Recipe.getDateTimeLastModified(), "dd-mm-yyyy HH:nn:ss") />

		<cfreturn returnData />
	</cffunction>

</cfcomponent>