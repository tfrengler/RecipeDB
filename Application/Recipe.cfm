<cfprocessingdirective pageEncoding="utf-8" />
<!--- CONTROLLER ACTIONS --->

<cftry>
	<cfset viewData = createObject("component", "Controllers.Recipes").getRecipeView(RecipeID=URL.RecipeID) />

	<!DOCTYPE html>
	<html lang="en" >

		<cfmodule template="Views/HTMLHead.cfm" pageJavascript="recipe" pageStylesheet="recipe" >

		<body class="roboto-font" >
			<cfinclude template="Views/Menu.cfm" />

			<div id="MainContent" class="container-fluid" >
				<cfmodule template="Views/Recipe.cfm" attributecollection=#viewData# >
			</div>

			<div id="Notification-Box" class="notification-box bottom-fixed-center col-lg-2" ></div>
		</body>
	</html>

	<cfcatch>
		<cfthrow object=#cfcatch# />
	</cfcatch>
</cftry>