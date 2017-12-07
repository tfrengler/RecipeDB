<cfprocessingdirective pageEncoding="utf-8" />

<cftry>
	<cfset viewData = createObject("component", "Controllers.Communication").getRoadmapView() />

	<!DOCTYPE html>
	<html lang="en" >

		<cfinclude template="Views/HTMLHead.cfm" />

		<body class="roboto-font" >
			<cfinclude template="Views/Menu.cfm" />

			<div id="MainContent" class="container-fluid" >
				<cfmodule template="Views/Roadmap.cfm" attributecollection=#viewData.data# >
			</div>

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