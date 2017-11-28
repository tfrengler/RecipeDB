<cfprocessingdirective pageencoding="utf-8" />
<cfinclude template="checkauth.cfm" />

<!DOCTYPE html>
<html lang="en" >
<cfoutput>

<head>
	<title>Toolbox: Communication Tools</title>

	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
</head>

<body>
	<p><a href="index.cfm?token=#URL.token#" >Back to Toolbox</a></p>
	<h1>User Tools</h1>

	<ul>
		<li><a href="PatchNotes.cfm?token=#URL.token#" >Patch notes</a></li>
		<li><a href="Roadmap.cfm?token=#URL.token#" >Roadmap</a></li>
		<!--- <li><a href="Notfications.cfm?token=#URL.token#" >Notifications</a></li> --->
	</ul>

</body>

</cfoutput>
</html>