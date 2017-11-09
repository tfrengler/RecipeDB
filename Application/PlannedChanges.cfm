<cfprocessingdirective pageEncoding="utf-8" />
<!--- CONTROLLER ACTIONS --->

<cftry>
	<cfset viewData = createObject("component", "Controllers.Communication").getRoadmapView() />

	<!DOCTYPE html>
	<html lang="en" >

		<cfinclude template="Views/HTMLHead.cfm" />

		<body class="roboto-font" >
			<cfinclude template="Views/Menu.cfm" />

			<div id="MainContent" class="container-fluid" >
				<cfmodule template="Views/Roadmap.cfm" attributecollection=#viewData# >
			</div>

			<div id="Notification-Box" class="notification-box col-lg-2 col-lg-offset-5" ></div>
		</body>
	</html>

	<cfcatch>
		<cfthrow object=#cfcatch# />
	</cfcatch>
</cftry>