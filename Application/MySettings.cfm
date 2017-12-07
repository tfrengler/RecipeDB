<cfprocessingdirective pageEncoding="utf-8" />

<cftry>
	<cfset viewData = createObject("component", "Controllers.Users").getUserSettingsView() />

	<!DOCTYPE html>
	<html lang="en" >

		<cfmodule template="Views/HTMLHead.cfm" pageJavascript="usersettings" >

		<body class="roboto-font" >
			<cfinclude template="Views/Menu.cfm" />

			<section id="MainContent" class="container-fluid" >
				<cfmodule template="Views/UserSettings.cfm" attributecollection=#viewData.data# >
			</section>

			<div id="Notification-Box" class="notification-box bottom-fixed-center col-lg-2 col-sm-4" ></div>
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