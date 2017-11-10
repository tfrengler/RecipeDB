<cfprocessingdirective pageEncoding="utf-8" />
<cftry>

	<!DOCTYPE html>
	<html lang="en" >

		<cfinclude template="Views/HTMLHead.cfm" />

		<body class="roboto-font" >
			<cfinclude template="Views/Menu.cfm" />

			<section id="MainContent" class="container-fluid" >
				<cfoutput>
					<h3 id="Welcome-Text-Name" class="olive-text-color-center" >Welcome #encodeForHTML( session.CurrentUser.getDisplayName() )#!</h3>
					<h3 id="Welcome-Text-PreviousLogin" class="olive-text-color-center" >Last time you visited us was on #encodeForHTML( dateTimeFormat(session.CurrentUser.getDateTimePreviousLogin(), "dd/mm/yyyy HH:nn") )#</h3>
				</cfoutput>
			</section>

			<div id="Notification-Box" class="notification-box col-lg-2 col-lg-offset-5" ></div>
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