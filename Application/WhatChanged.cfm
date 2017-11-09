<cfprocessingdirective pageEncoding="utf-8" />
<!--- CONTROLLER ACTIONS --->

<cftry>
	<cfset viewData = createObject("component", "Controllers.Communication").getPatchNotesView() />

	<!DOCTYPE html>
	<html lang="en" >

		<cfinclude template="Views/HTMLHead.cfm" />

		<body class="roboto-font" >
			<cfinclude template="Views/Menu.cfm" />

			<section id="MainContent" class="container-fluid roboto-font" >
				<cfmodule template="Views/PatchNotes.cfm" attributecollection=#viewData# >
			</section>

			<div id="Notification-Box" class="notification-box col-lg-2 col-lg-offset-5" ></div>
		</body>
	</html>

	<cfcatch>
		<cfthrow object=#cfcatch# />
	</cfcatch>
</cftry>