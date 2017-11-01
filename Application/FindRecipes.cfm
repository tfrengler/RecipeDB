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

			<div id="Notification-Box" class="notification-box col-lg-2 col-lg-offset-5" ></div>
		</body>
	</html>

	<cfcatch>
		<cfthrow object=#cfcatch# />
	</cfcatch>
</cftry>