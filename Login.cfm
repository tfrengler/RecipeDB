<cfprocessingdirective pageencoding="utf-8" />
<cfparam name="URL.Reason" type="numeric" default="0" />

<!DOCTYPE html>
<html lang="en" >

<head>
	<title>RecipeDB</title>

	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

	<link rel="shortcut icon" href="Application/Assets/Pictures/Standard/favicon.ico" type="image/x-icon" />
	<link rel="icon" href="Application/Assets/Pictures/Standard/favicon.ico" type="image/x-icon" />

	<script type="text/javascript" src="Application/Assets/Libs/jquery-base/jquery-min.js"></script>
	<script type="text/javascript" src="Application/Assets/Libs/tinymce/jquery.tinymce.min.js"></script>
	<script type="text/javascript" src="Application/Assets/Libs/tinymce/tinymce.min.js" ></script>
	<script type="text/javascript" src="Application/Assets/JS/main.js"></script>
	<script type="text/javascript" src="Application/Assets/JS/login.js" ></script>

	<link rel="stylesheet" type="text/css" href="Application/Assets/Libs/bootstrap/css/bootstrap.min.css" />
	<link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet" />
	<link rel="stylesheet" href="Application/Assets/Libs/font-awesome/css/font-awesome.min.css" />
	<link rel="stylesheet" type="text/css" href="Application/Assets/CSS/main.css" />
	<link rel="stylesheet" type="text/css" href="Application/Assets/CSS/login.css" />
</head>

<body>

	<section id="Content" class="container-fluid roboto-font" >
		<h1 id="Login-Welcome" class="olive-text-color-center" >RecipeDB</h1>

		<br/>

		<form id="Login-Form" class="olive-wrapper-grey-background col-lg-2 col-lg-offset-5 col-sm-4 col-sm-offset-4" action="Login.cfm" method="POST" onsubmit="return false" >

			<h3 id="Login-Header" class="form-signin-heading" >Please log in</h3>

			<div class="input-group"> 
				<span class="input-group-addon"><i class="fa fa-user-o fa-fw"></i></span>
				<input id="Username" name="j_username" class="form-control" type="text" placeholder="username" />
			</div>

			<div class="input-group"> 
				<span class="input-group-addon"><i class="fa fa-lock fa-fw"></i></span>
				<input id="Password" name="j_password" class="form-control" type="password" />
			</div>

			<br/>
			<input id="Login-Button" type="submit" value="LOG IN" class="standard-button btn-block" />

		</form>

		<div id="Notification-Box" class="notification-box col-lg-2 col-lg-offset-5 col-sm-4 col-sm-offset-4" ></div>
	</section>

	<script type="text/javascript">
		$(document).ready(function() {
			RecipeDB.page.init();

		<cfif structKeyExists(COOKIE, "CFID") IS false AND structKeyExists(COOKIE, "CFTOKEN") IS false >
			$('#' + RecipeDB.page.constants.MESSAGEBOX_ID).addClass("red-error-text");
			$('#' + RecipeDB.page.constants.MESSAGEBOX_ID).html("Your browser doesn't support cookies or cookies are not enabled<br/><br/>Cookies are required if you want to use this application");
			$('#' + RecipeDB.page.constants.MESSAGEBOX_ID).fadeIn(1000);

		<cfelseif URL.Reason GT 0 >
			<cfif URL.Reason IS 5 >
			$('#' + RecipeDB.page.constants.MESSAGEBOX_ID).addClass("red-error-text");
			$('#' + RecipeDB.page.constants.MESSAGEBOX_ID).html("Your session has expired. You need to log in again");
			$('#' + RecipeDB.page.constants.MESSAGEBOX_ID).fadeIn(1000);
			<cfelseif URL.Reason IS 6 >
			$('#' + RecipeDB.page.constants.MESSAGEBOX_ID).addClass("green-success-text");
			$('#' + RecipeDB.page.constants.MESSAGEBOX_ID).html("You've been logged out");
			$('#' + RecipeDB.page.constants.MESSAGEBOX_ID).fadeIn(1000);
			<cfelse>
			$('#' + RecipeDB.page.constants.MESSAGEBOX_ID).addClass("red-error-text");
			$('#' + RecipeDB.page.constants.MESSAGEBOX_ID).html("Username or password is not correct");
			$('#' + RecipeDB.page.constants.MESSAGEBOX_ID).fadeIn(1000);
		</cfif>

		</cfif>
		});
	</script>

</body>
</html>