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
				<cfmodule template="Views/UserSettings.cfm" attributecollection=#viewData.data# >
			</section>
		</body>

		<div id="Notification-Box" class="notification-box bottom-fixed-center col-lg-2" ></div>
	</html>

	<cfcatch>
		<cfthrow object=#cfcatch# />
	</cfcatch>
</cftry>