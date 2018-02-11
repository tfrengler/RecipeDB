<cfprocessingdirective pageEncoding="utf-8" />
<cfoutput>
<cftry>

	<!DOCTYPE html>
	<html lang="en" >

		<cfinclude template="Modules/HTMLHead.cfm" />

		<body class="roboto-font" >
			<cfinclude template="Views/Menu.cfm" />

			<section id="MainContent" class="container-fluid" >
					<br/>
					<section id="Welcome-Wrapper" class="olive-wrapper-grey-background standard-rounded-corners col-lg-4 col-lg-offset-4 col-sm-8 col-sm-offset-2 standard-box-shadow" >
						
						<h3 id="Welcome-Text-Name" class="olive-text-color-center" >Welcome #encodeForHTML( session.CurrentUser.getDisplayName() )#!</h3>
						<h3 id="Welcome-Text-PreviousLogin" class="olive-text-color-center" >
							<cfif dateCompare(session.CurrentUser.getDateTimePreviousLogin(), createDate(2000, 1, 1)) GT 0 >
								Last time you visited us was on #encodeForHTML( dateTimeFormat(session.CurrentUser.getDateTimePreviousLogin(), "dd/mm/yyyy HH:nn") )#
							<cfelse>
								We see you are a new user! Welcome, hope you enjoy using this program
							</cfif>
						</h3>
					
					</section>
			</section>

			<div id="Notification-Box" class="notification-box top-fixed-center col-lg-2 col-lg-offset-5 col-sm-4 col-sm-offset-4" ></div>
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

</cfoutput>