<cfprocessingdirective pageencoding="utf-8" />
<cfparam name="URL.Reason" default="0" />

<!DOCTYPE html>
<html lang="en" >

<head>
	<title>RecipeDB</title>

	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<script type="text/javascript" src="Application/Assets/Libs/jquery-base/jquery-min.js"></script>
	<script type="text/javascript" src="Application/Assets/Libs/tinymce/jquery.tinymce.min.js"></script>
	<script type="text/javascript" src="Application/Assets/Libs/tinymce/tinymce.min.js" ></script>
	<script type="text/javascript" src="Application/Assets/main.js"></script>

	<link rel="stylesheet" type="text/css" href="Application/Assets/Libs/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="Application/Assets/main.css" >
</head>

<body>

	<div id="Content" class="container" >
		<h1 id="Login-Welcome" class="olive-text-color-center" >RecipeDB</h1>

		<form id="Login-Form" class="olive-wrapper-grey-background center-block" >

			<h3 id="Login-Header" class="form-signin-heading" >Please log in</h3>

			<input id="Username" name="Username" class="form-control" type="text" placeholder="username" />
			<input id="Password" name="Password" class="form-control" type="password" placeholder="password" />

			<input id="Login-Button" type="button" value="OK" class="standard-button btn-block" />

		</form>

		<div id="Login-MessageBox" class="center-block" ></div>
	</div>

	<script type="text/javascript">
		$(document).ready(function() {
			RecipeDB.LoginPage.init();
		});

		<cfif structKeyExists(cookie, "CFID") IS false AND structKeyExists(cookie, "CFTOKEN") IS false >
			$('#' + RecipeDB.LoginPage.MessageBoxID).html("Your browser doesn't support cookies or cookies are not enabled.<br/><br/>Cookies are required if you want to use this application.");
			$('#' + RecipeDB.LoginPage.MessageBoxID).fadeIn(1000);

		<cfelseif URL.Reason GT 0 >
			<cfif URL.Reason IS 1 >
				$('#' + RecipeDB.LoginPage.MessageBoxID).html("Your session has expired. You need to log in again");
				$('#' + RecipeDB.LoginPage.MessageBoxID).fadeIn(1000);
			<cfelseif URL.Reason IS 2 >
				$('#' + RecipeDB.LoginPage.MessageBoxID).html("You've been logged out successfully");
				$('#' + RecipeDB.LoginPage.MessageBoxID).fadeIn(1000);
			<cfelse>
				console.warn("unknown response reason");
			</cfif>

		</cfif>
	</script>
</body>

</html>