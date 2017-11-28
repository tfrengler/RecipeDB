<cfprocessingdirective pageencoding="utf-8" />
<cfinclude template="checkauth.cfm" />

<!DOCTYPE html>
<html lang="en" >
<cfoutput>

<head>
	<title>Toolbox: DB Tools</title>

	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
</head>

<body>
	<p><a href="index.cfm?token=#URL.token#" >Back to Toolbox</a></p>
	<h1>DB Tools</h1>
	
	<h3>Information</h3>

	<ul>
		<li><a href="DBInspection.cfm?token=#URL.token#" >DB Inspection</a></li>
		<li><a href="DBHealthCheck.cfm?token=#URL.token#" >DB Health Check</a></li>
		<li><a href="DBStructureChart.cfm?token=#URL.token#" >DB Structure Chart</a></li>
		<li><a href="ListRecipes.cfm?token=#URL.token#" >List of recipes</a></li>
	</ul>

	<!--- <h3>Table manipulation</h3>

	<ul>
		<li><a href="" >Add/remove table</a></li>
		<li><a href="" >Add/remove column(s)</a></li>
		<li><a href="" >Edit column(s)</a></li>
	</ul> --->

</body>

</cfoutput>
</html>