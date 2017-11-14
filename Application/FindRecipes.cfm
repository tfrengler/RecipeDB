<cfprocessingdirective pageEncoding="utf-8" />
<cftry>

	<!DOCTYPE html>
	<html lang="en" >

		<cfmodule template="Views/HTMLHead.cfm" pageJavascript="recipelist" pageStylesheet="recipelist" >

		<body class="roboto-font" >
			<cfinclude template="Views/Menu.cfm" />

			<section id="MainContent" class="container-fluid" >
				<cfinclude template="Views/RecipeList.cfm" />
			</section>

			<div id="Notification-Box" class="notification-box col-lg-2 col-lg-offset-5 col-sm-4 col-sm-offset-4" ></div>
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