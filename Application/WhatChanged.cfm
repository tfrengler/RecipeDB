<cfprocessingdirective pageEncoding="utf-8" />
<!--- CONTROLLER ACTIONS --->

<cftry>
	<cfset viewData = createObject("component", "Controllers.Communication").getPatchNotesView() />

	<!DOCTYPE html>
	<html lang="en" >

		<cfinclude template="Views/HTMLHead.cfm" />

		<body class="roboto-font" >
			<cfinclude template="Views/Menu.cfm" />


			<section id="MainContent" class="container-fluid" >

				<cfif viewData.statuscode IS 0 >
					<cfmodule template="Views/PatchNotes.cfm" attributecollection=#viewData.data# >
				<cfelse>
					<cfinclude template="Views/Error.cfm?ErrorCode=#viewData.statuscode#" />
				</cfif>	

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