<!DOCTYPE html> 
<html lang="en" >

<cfinclude template="/Modules/HTMLHead.cfm" />

<body>

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

		<h3 id="Help-Text" class="olive-text-color center-block" >Can't remember your login details or have trouble logging in? Contact the administrator</h3>
	</div>

</body>

</html>