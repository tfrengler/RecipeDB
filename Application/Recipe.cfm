<cfprocessingdirective pageEncoding="utf-8" />

<cftry>
	<cfset viewData = createObject("component", "Controllers.GetRecipeView").main(
		recipeID=URL.RecipeID,
		currentUser=session.currentUser
	) />

	<!DOCTYPE html>
	<html lang="en" >

		<cfmodule template="Modules/HTMLHead.cfm" pageJavascript="recipe" pageStylesheet="recipe" >

		<body class="roboto-font" >
			<cfinclude template="Views/Menu.cfm" />

			<div id="MainContent" class="container-fluid" >

				<cfif viewData.statuscode IS 1 >

					<div id="Error-Box" style="display: block" class="notification-box red-error-text top-fixed-center col-lg-2" >
						Sorry, we can't let you access this recipe. It's not published or it doesn't belong to you.
					</div>

				<cfelseif viewData.statuscode IS 2 >

					<div id="Error-Box" style="display: block" class="notification-box red-error-text top-fixed-center col-lg-2" >
						We are very sorry, but we can't find a recipe for you with ID <cfoutput>#URL.RecipeID#</cfoutput>. Either it never existed or it has been deleted.
					</div>

				<cfelseif viewData.statuscode IS 3 >

					<div id="Error-Box" style="display: block" class="notification-box red-error-text top-fixed-center col-lg-2" >
						Sorry, but the RecipeID we received was 0 or less. That isn't supposed to be able to happen...
					</div>

				<cfelseif viewData.statuscode IS 0 >
					<cfmodule template="Views/Recipe.cfm" attributecollection=#viewData.data# >
				</cfif>

			</div>

			<div id="Notification-Box" class="notification-box top-fixed-center col-lg-2 col-sm-4" ></div>
		</body>
	</html>

	<cfcatch>
		<cfif isUserInRole("Admin") >
			<cfthrow object=#cfcatch# />
		<cfelse>
			<cfinclude template="Views/Error.cfm" />
		</cfif>
	</cfcatch>
</cftry>