<cfscript>
	if (!application.SecurityManager.IsValidSession(cookie, session))
	{
		application.SecurityManager.NewSession(session);
	}
</cfscript>

<cftry>
	<cfset Nonce = application.SecurityManager.GenerateNonce() />
	<cfheader name="Content-Security-Policy" value="script-src 'nonce-#Nonce#' 'strict-dynamic'; style-src 'self' https://fonts.googleapis.com" />

	<cfoutput>
	<!DOCTYPE html>
	<html lang="en" >

	<head>
		<title>RecipeDB</title>

		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

		<link rel="shortcut icon" href="Application/Assets/Pictures/Standard/favicon.ico" type="image/x-icon" />
		<link rel="icon" href="Application/Assets/Pictures/Standard/favicon.ico" type="image/x-icon" />

		<script nonce="#Nonce#" src="Application/Assets/Libs/jquery-base/jquery-min.js"></script>
		<script nonce="#Nonce#" src="Application/Assets/JS/main.js"></script>
		<script nonce="#Nonce#" type="module" src="Application/Assets/JS/login.js" ></script>

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

			<form id="Login-Form" class="olive-wrapper-grey-background col-lg-2 col-lg-offset-5 col-sm-4 col-sm-offset-4 standard-box-shadow" action="Login.cfm" method="POST" >

				<h3 id="Login-Header" class="form-signin-heading" >Please log in</h3>

				<div class="input-group">
					<span class="input-group-addon olive-background-color"><i class="fa fa-user-o fa-fw"></i></span>
					<input id="Username" name="username" class="form-control" type="text" placeholder="username" />
				</div>

				<div class="input-group">
					<span class="input-group-addon olive-background-color"><i class="fa fa-lock fa-fw"></i></span>
					<input id="Password" name="password" class="form-control" type="password" />
				</div>

				<br/>
				<input id="Login-Button" type="submit" value="LOG IN" class="standard-button btn-block" />

			</form>

			<div id="Notification-Box" class="notification-box col-lg-2 col-lg-offset-5 col-sm-4 col-sm-offset-4" ></div>
		</section>

	</body>
	</html>
	</cfoutput>

	<cfcatch>
		<cfcontent reset="true" />
		<cfinclude template="Application/Views/Error.cfm" />
	</cfcatch>
</cftry>