<cfprocessingdirective pageEncoding="utf-8" />
<cftry>
	
	<!DOCTYPE html>
	<html lang="en" >

		<cfmodule template="Views/HTMLHead.cfm" pageJavascript="addrecipe" pageStylesheet="addrecipe" >

		<body class="roboto-font" >
			<cfinclude template="Views/Menu.cfm" />

			<section id="MainContent" class="container-fluid" >
				<cfinclude template="Views/AddRecipe.cfm" />
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