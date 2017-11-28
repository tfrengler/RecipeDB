<cfprocessingdirective pageencoding="utf-8" />
<cfinclude template="checkauth.cfm" />

<!DOCTYPE html>
<html lang="en" >
<cfoutput>

<head>
	<title>Toolbox: User Tools</title>

	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
</head>

<body>
	<p><a href="index.cfm?token=#URL.token#" >Back to Toolbox</a></p>
	<h1>User Tools</h1>

	<ul>
		<li><a href="AddUser.cfm?token=#URL.token#" >Add user</a></li>
		<!--- <li><a href="EditUser.cfm?token=#URL.token#" >Edit user</a></li> --->
		<li><a href="ListUsers.cfm?token=#URL.token#" >List users</a></li>
	</ul>

</body>

</cfoutput>
</html>