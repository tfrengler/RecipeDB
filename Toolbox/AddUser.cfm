<cfinclude template="CheckAuth.cfm" />

<!DOCTYPE html>
<html lang="en" >
<cfoutput>

<head>
	<title>Toolbox: Add User</title>

	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<style type="text/css">
		fieldset {
			width: 30%;
		}

		.bad {
			background-color: red;
			color: white;
			font-weight: bold;
			width: 30%;
		}

		.good {
			background-color: green;
			color: white;
			font-weight: bold;
			width: 30%;
		}
	</style>

</head>

<body>

	<p><a href="UserTools.cfm" >Back to User Tools</a></p>
	<h1>Add user</h1>

	<fieldset>

		<form action="AddUser.cfm" method="post" >
			<p>
				<div class="form-field-label" >Username: </div>
				<input type="text" name="UserName" value="" />
			</p>
			<p>
				<div class="form-field-label" >Display name: </div>
				<input type="text" name="DisplayName" value="" />
			</p>
			<p>
				<div class="form-field-label" >Passsword: </div>
				<input type="text" name="Password" value="" />
			</p>
			<p>
				<input type="submit" value="ADD" />
			</p>
		</form>

	</fieldset>

	<cfif structIsEmpty(FORM) IS false >
		<cfset UsersInterface = createObject("component", "Models.User") />
		<cfset Continue = true />

		<cfif len(FORM.UserName) IS 0 >
			<p class="bad" >Username is empty!</p>
			<cfset Continue = false />
		</cfif>

		<cfif len(FORM.Password) IS 0 >
			<p class="bad" >Password is empty!</p>
			<cfset Continue = false />
		</cfif>

		<cfif len(FORM.UserName) GT 0 >
			<cfset ExistingUsers = UsersInterface.getBy( 
				ColumnToSearchOn="username",
				SearchOperator="equal to",
				SearchData=FORM.UserName
			) />

			<cfif ExistingUsers.RecordCount GT 0 >
				<p class="bad" >There's already one or more users with that username!</p>
				<cfdump var=#ExistingUsers# />
				<cfset Continue = false />
			</cfif>
		</cfif>

		<cfif Continue >
			<cfset NewUserInstance = UsersInterface.create(Username=FORM.UserName) />

			<cfset NewUserInstance.changePassword(
				SecurityManager=application.securityManager,
				Password=FORM.Password
			) />

			<cfset NewUserInstance.setBlocked( Blocked=false ) />

			<cfif len(FORM.DisplayName) GT 0 >
				<cfset NewUserInstance.setDisplayName( Name=FORM.DisplayName ) />
			</cfif>
			
			<cfset NewUserInstance.save() />

			<p class="good" >SUCCESS! New user added!</p>

			<cfdump var=#UsersInterface.getData(ID=NewUserInstance.getId())# />
		</cfif>
	</cfif>

</body>

</cfoutput>
</html>