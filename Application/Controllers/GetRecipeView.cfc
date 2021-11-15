<cfcomponent output="false" >
<cfprocessingdirective pageEncoding="utf-8" />

	<cffunction name="main" access="public" returntype="struct" output="false" hint="" >
		<cfargument name="recipeID" type="numeric" required="true" />
		<cfargument name="currentUser" type="Models.User" required="true" />

		<cfset var returnData = {
			statuscode: 0,
			data: structNew()
		} />

		<cfif arguments.recipeID LTE 0 >

			<cfset returnData.statuscode = 3 />
			<cfreturn returnData />

		</cfif>

		<cfif Models.Recipe::Exists(ID=arguments.recipeID) IS false >

			<cfset returnData.statuscode = 2 />
			<cfreturn returnData />

		</cfif>

		<cfset var Recipe = createObject("component", "Models.Recipe").init(arguments.RecipeID) />

		<cfif Recipe.GetCreatedByUser().GetUserID() IS NOT arguments.currentUser.GetUserID() >
			<cfif Recipe.GetPublished() IS false >

				<cfset returnData.statuscode = 1 />
				<cfreturn returnData />

			</cfif>
		</cfif>

		<cfset returnData.data.RecipeID = Recipe.GetRecipeID() />
		<cfset returnData.data.Name = Recipe.getName() />
		<cfset returnData.data.DateCreated = Recipe.getDateTimeCreated() />
		<cfset returnData.data.DateTimeLastModified = Recipe.getDateTimeLastModified() />
		<cfset returnData.data.CreatedByUserName = Recipe.getCreatedByUser().getDisplayName() />
		<cfset returnData.data.CreatedByUserID = Recipe.getCreatedByUser().GetUserID() />
		<cfset returnData.data.LastModifiedByUser = Recipe.getLastModifiedByUser().getDisplayName() />
		<cfset returnData.data.Ingredients = Recipe.getIngredients() />
		<cfset returnData.data.Description = Recipe.getDescription() />
		<cfset returnData.data.Instructions = Recipe.getInstructions() />
		<cfset returnData.data.Published = Recipe.getPublished() />
		<!--- <cfset returnData.Comments = Recipe.getComments() /> --->

		<cfif len(Recipe.getPicture()) IS 0 >
			<cfset returnData.data.Picture = "Assets/Pictures/Standard/foodexample.jpg" />
		<cfelse>
			<cfset returnData.data.Picture = "Modules/RecipeImageDownloader.cfm?fileName=#Recipe.getPicture()#.png" />
		</cfif>

		<cfreturn returnData />
	</cffunction>

</cfcomponent>