<cfprocessingdirective pageEncoding="utf-8" />
<!--- CONTROLLER ACTIONS --->

<cftry>
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
						This recipe is not owned by you or it's not published
					</div>
				<cfelse>
					<cfmodule template="Views/Recipe.cfm" attributecollection=#viewData.data# >
				</cfif>

			</div>

			<div id="Notification-Box" class="notification-box bottom-fixed-center col-lg-2" ></div>
		</body>
	</html>

	<cfcatch>
		<!--- <cfinclude template="Views/Error.cfm" /> --->
		<cfthrow object=#cfcatch# />
	</cfcatch>
</cftry>