<cfprocessingdirective pageEncoding="utf-8" />

<!DOCTYPE html>
<html lang="en" >

	<cfinclude template="../Modules/HTMLHead.cfm" />

	<body>
		<cfinclude template="Menu.cfm" />

		<div id="MainContent" class="container-fluid" >
			<!--- <cfdump var="#variables#" />
			<cfdump var="#session#" />
			<cfdump var="isUserLoggedIn: #isUserLoggedIn()#" />
			
			<cfquery name="user" datasource="#application.settings.datasource#" >
				SELECT *
				FROM Users
				WHERE UserID = #session.CurrentUser.getUserID()#
			</cfquery>

			<cfdump var="#user#" /> --->
		</div>
	</body>
</html>