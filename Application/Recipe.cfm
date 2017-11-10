<cfprocessingdirective pageEncoding="utf-8" />

<cftry>
	<cfparam name="URL.RecipeID" type="numeric" default="0" />

	<cfset viewData = createObject("component", "Controllers.Recipes").getRecipeView(
		recipeID=URL.RecipeID,
		currentUser=session.currentUser
	) />

	<!DOCTYPE html>
	<html lang="en" >

		<cfmodule template="Views/HTMLHead.cfm" pageJavascript="recipe" pageStylesheet="recipe" >

		<body class="roboto-font" >
			<cfinclude template="Views/Menu.cfm" />

			<div id="MainContent" class="container-fluid" >

				<cfif viewData.status IS "NOK" AND viewData.errorcode IS 1 >
					<div id="Notification-Box" style="display: block" class="notification-box red-error-text top-fixed-center col-lg-2" >
						Sorry, we can't let you access this recipe. It's not published or it doesn't belong to you.
					</div>
				<cfelse>
					<cfmodule template="Views/Recipe.cfm" attributecollection=#viewData.data# >
				</cfif>

			</div>

			<div id="Notification-Box" class="notification-box bottom-fixed-center col-lg-2" ></div>
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