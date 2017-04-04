<!DOCTYPE html> 
<html lang="en" >

<cfinclude template="/Modules/HTMLHead.cfm" />
<cfparam name="URL.Reason" default="0" />

<body>
	<style type="text/css">
		#Login-MessageBox {
			border-style: solid;
			border-width: 1px;
			border-color: black;
			padding: 0.5em;
			background-color: red; 
			color: white;
			max-width: 20em;
			display: none;
		}
	</style>

	<div id="Content" class="container" >
		<h1 id="Login-Welcome" class="olive-text-color-center" >Welcome to the RecipeDB</h1>

		<form id="Login-Form" class="olive-wrapper-grey-background center-block" >

			<h3 id="Login-Header" class="form-signin-heading" >Please log in</h3>

			<input id="Username" name="Username" class="form-control" type="text" placeholder="username" />
			<input id="Password" name="Password" class="form-control" type="password" placeholder="password" />
			<input id="Remember-Me" name="RememberMe" type="checkbox" />
			<span>Remember me</span>

			<input id="Login-Button" type="button" value="Log in" class="standard-button btn-block" />

		</form>

		<div id="Login-MessageBox" class="center-block" ></div>

		<h3 id="Help-Text" class="olive-text-color center-block" >Can't remember your login details or have trouble logging in? Contact the administrator</h3>
	</div>

	<script type="text/javascript">
		$(document).ready(function() {

			$('#Login-Button').click(function() {

				var Password = $('#Password').val();
				var Username = $('#Username').val();

				$.ajax({

					type: "post",
					url: "../Controllers/Users.cfc",
					data: {
						method: "attemptLogin",
						password: Password,
						username: Username
					},
					dataType: "json",

					success: function(ResponseData) {
						OnLoginComplete(ResponseData);
					},
					error: function() {
						OnLoginError(arguments);
					}

				});

			});

			<cfif URL.Reason GT 0 >
				<cfif URL.Reason IS 1 >
					$('#Login-MessageBox').html("Your session has expired.<br/>You need to log in again");
				<cfelseif URL.Reason IS 2 >
					$('#Login-MessageBox').html("You've been logged out successfully");
				</cfif>
				$('#Login-MessageBox').fadeIn(1000);
			</cfif>
		});

		function OnLoginComplete(AjaxResponse) {

			if (AjaxResponse.RESULT === false) {
				if (AjaxResponse.CODE === 1) {
					$('#Login-MessageBox').html("The username is wrong or does not exist");
				}
				else if (AjaxResponse.CODE === 2) {
					$('#Login-MessageBox').html("The password is wrong");
				}

				$('#Login-MessageBox').fadeIn(1000).delay(3000).fadeOut(1000);
				return false;
			};

			window.location.href = "Recipe.cfm";
			return true;
		};

		function OnLoginError() {

		};
	</script>
</body>

</html>