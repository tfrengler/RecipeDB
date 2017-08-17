<cfprocessingdirective pageencoding="utf-8" />
<cfinclude template="checkauth.cfm" />

<!DOCTYPE html>
<html lang="en" >
<cfoutput>

<head>
	<title>Toolbox</title>

	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
</head>

<body>
	<h1>Toolbox</h1>
	
	<ul>
		<li><a href="DBTools.cfm?token=#URL.token#" >DB tools</a></li>
	</ul>

</body>

</cfoutput>
</html>