<cfprocessingdirective pageencoding="utf-8" />
<cfparam name="URL.token" default="0" />
<cfif URL.token IS NOT 86954494 >
	<p>Look at you, hacker: a pathetic creature of meat and bone, panting and sweating as you run through my corridors. How can you challenge a perfect, immortal machine?</p>
	<cfabort/>
</cfif>

<!DOCTYPE html>
<html lang="en" >

<head>
	<title>DB Health Check</title>
	<style type="text/css">
		.error {
			color: red;
		}
	</style>
</head>

<form name="ToolboxForm" action="POST" >
	<input name="DoDatabaseCheck" type="hidden" value="0" />

	<p>Do a database check: <input type="submit" value="GO" /></p>

</form>