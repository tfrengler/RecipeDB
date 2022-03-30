<!--- CONTROLLER ACTIONS --->
<cftry>
	<cfmodule template="Modules/ScriptNonce.cfm" >
	<cfset controller = new Controllers.GetRecipeListDataSimple() />

	<cfif NOT structIsEmpty(FORM) >

		<!--- This is triggered when we use the filter to look for recipes --->
		<cfset REQUEST.filtersettings = FORM />
		<cfset controllerReturnData = controller.main(filterSettings=FORM) />
		<cfset viewData.filter = structNew() />

	<cfelse>

		<cfset controllerReturnData = controller.main(filterSettings=session.currentUser.getSettings().findRecipes.filter) />
		<cfset viewData.filter = session.currentUser.getSettings().findRecipes.filter />

	</cfif>

	<cfset viewData.recipes = controllerReturnData.data />

	<!DOCTYPE html>
	<html lang="en" >

		<cfmodule template="Modules/HTMLHead.cfm" pageJavascript="recipelistsimple" pageStylesheet="recipelistsimple" >

		<body class="roboto-font" >
			<cfinclude template="Views/Menu.cfm" />

			<section id="MainContent" class="container-fluid" >
				<cfmodule template="Views/RecipeListAsThumbnails.cfm" attributecollection=#viewData# >
			</section>

			<div id="Notification-Box" class="notification-box bottom-fixed-center col-lg-2 col-lg-offset-5 col-sm-4 col-sm-offset-4" ></div>
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