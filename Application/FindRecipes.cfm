<cfprocessingdirective pageEncoding="utf-8" />
<cfparam name="URL.fromMenu" type="integer" default="1" />

<!--- CONTROLLER ACTIONS --->
<cftry>

	<cfif session.currentUser.getSettings().findRecipes.listType IS "simple" AND URL.fromMenu IS 1 >
		<cflocation url="FindRecipesAsThumbnails.cfm" addtoken="false" />
	</cfif>

	<cfset viewData = {
		listSwitchButtonType: "simple",
		filter: session.currentUser.getSettings().findRecipes.filter,
		sortOnColumn: session.currentUser.getSettings().findRecipes.sortOnColumn
	} />

	<!DOCTYPE html>
	<html lang="en" >

		<cfmodule template="Modules/HTMLHead.cfm" pageJavascript="recipelist" pageStylesheet="recipelist" >

		<body class="roboto-font" >
			<cfinclude template="Views/Menu.cfm" />

			<section id="MainContent" class="container-fluid" >
				<cfmodule template="Views/RecipeList.cfm" attributecollection=#viewData# >
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