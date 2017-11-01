<cfprocessingdirective pageEncoding="utf-8" />
<!--- CONTROLLER ACTIONS --->

<cftry>
	<cfset viewData = createObject("component", "Controllers.Users").getUserSettingsView() />

<!--- VIEW --->

	<!DOCTYPE html>
	<html lang="en" >

		<cfmodule template="Views/HTMLHead.cfm" pageJavascript="usersettings" >

		<body class="roboto-font" >
			<cfinclude template="Views/Menu.cfm" />

			<section id="MainContent" class="container-fluid" >
				<cfmodule template="Views/UserSettings.cfm" attributecollection=#viewData# >
			</section>
		</body>

		<div id="Notification-Box" class="notification-box col-lg-2 col-lg-offset-5" ></div>
	</html>

	<cfcatch>
		<cfthrow object=#cfcatch# />
	</cfcatch>
</cftry>