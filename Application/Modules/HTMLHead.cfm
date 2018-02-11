<!--- MODULE --->

<cfoutput>
<cfparam name="attributes.pageJavascript" type="string" default="" />
<cfparam name="attributes.pageStylesheet" type="string" default="" />
<cfparam name="attributes.includeMenu" type="boolean" default="true" />

<head>
	<title>RecipeDB</title>

	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

	<link rel="shortcut icon" href="Assets/Pictures/Standard/favicon.ico" type="image/x-icon" />
	<link rel="icon" href="Assets/Pictures/Standard/favicon.ico" type="image/x-icon" />

	<script type="text/javascript" src="Assets/Libs/jquery-base/jquery-min.js"></script>
	<script type="text/javascript" src="Assets/Libs/jquery-ui/jquery-ui.min.js"></script>
	<script type="text/javascript" src="Assets/Libs/tinymce/jquery.tinymce.min.js"></script>
	<script type="text/javascript" src="Assets/Libs/tinymce/tinymce.min.js" ></script>
	<script type="text/javascript" src="Assets/Libs/datatables/media/js/jquery.dataTables.min.js" ></script>
	<script type="text/javascript" src="Assets/JS/main.js"></script>

	<cfif attributes.includeMenu >
		<script type="text/javascript" src="Assets/JS/menu.js"></script>
	</cfif>

	<cfif len(attributes.pageJavascript) GT 0 >
		<script type="text/javascript" src="Assets/JS/#attributes.pageJavascript#.js"></script>
	</cfif>

	<link rel="stylesheet" type="text/css" href="Assets/Libs/bootstrap/css/bootstrap.min.css" />
	<link rel="stylesheet" type="text/css" href="Assets/Libs/jquery-ui/jquery-ui.min.css" />
	<link rel="stylesheet" type="text/css" href="Assets/Libs/datatables/media/css/jquery.dataTables.min.css" />
	<link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet" />
	<link rel="stylesheet" href="Assets/Libs/font-awesome/css/font-awesome.min.css" />
	<link rel="stylesheet" type="text/css" href="Assets/CSS/main.css" />

	<cfif len(attributes.pageStylesheet) GT 0 >
		<link rel="stylesheet" type="text/css" href="Assets/CSS/#attributes.pageStylesheet#.css" />
	</cfif>
	<cfif attributes.includeMenu >
		<link rel="stylesheet" type="text/css" href="Assets/CSS/menu.css" />
	</cfif>

	<script type="text/javascript">
		$(document).ready(function() {
			RecipeDB.main.init();
			<cfoutput>#toScript(session.AuthKey, "RecipeDB.main.constants.AUTH_KEY", false)#</cfoutput>
			RecipeDB.main.constants = Object.freeze(RecipeDB.main.constants);
			
			if (RecipeDB.page !== undefined) {
				RecipeDB.page.init();
				RecipeDB.page.constants = Object.freeze(RecipeDB.page.constants);
			} else {
				console.log("No page JS to init");
			};
			
			<cfif attributes.includeMenu >
				RecipeDB.menu.init();
			<cfelse>
				console.log("No menu to init");
			</cfif>

			<cfif isUserInRole("Admin") >
				RecipeDB.main.debug = true;
				console.log("Debugging is ON");
			<cfelse>
				console.log("Debugging is OFF");
			</cfif>
		});
	</script>
</head>

</cfoutput>