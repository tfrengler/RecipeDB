<cfprocessingdirective pageEncoding="utf-8" />

<!DOCTYPE html>
<html lang="en" >

	<cfinclude template="../Modules/HTMLHead.cfm" />

	<body>
		<cfinclude template="Menu.cfm" />

		<div id="MainContent" class="container-fluid" >
			<cfoutput>
				<h3 id="Welcome-Text-Name" class="olive-text-color-center" >Welcome #encodeForHTML( session.CurrentUser.getDisplayName() )#!</h3>
				<h3 id="Welcome-Text-PreviousLogin" class="olive-text-color-center" >Last time you visited us was on #encodeForHTML( dateTimeFormat(session.CurrentUser.getDateTimePreviousLogin(), "dd/mm/yyyy HH:nn") )#</h3>
			</cfoutput>
		</div>
	</body>

	<script type="text/javascript">
		$(document).ready(function() {
			RecipeDB.Main.init();
		});
	</script>
</html>