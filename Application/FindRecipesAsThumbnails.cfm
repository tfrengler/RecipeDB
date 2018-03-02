<cfprocessingdirective pageEncoding="utf-8" />
<!--- CONTROLLER ACTIONS --->

<cftry>
	<cfset controller = createObject("component", "Controllers.GetRecipeListDataSimple") />

	<cfif structIsEmpty(FORM) IS false >
		<cfset REQUEST.filtersettings = FORM />
		<cfset contollerReturnData = controller.main(filterSettings=FORM) />
	<cfelse>
		<cfset contollerReturnData = controller.main() />
	</cfif>
	
	<cfset viewData.recipes = contollerReturnData.data />

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