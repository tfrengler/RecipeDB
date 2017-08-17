<cfparam name="AuthFailed" type="boolean" default="false" />

<cftry>
	<cfparam name="URL.token" type="uuid" default="0" />

	<cfif URL.token IS NOT "1895708B-AA14-4FC6-AC4549ADDB4BEBB0" >
		<cfset AuthFailed = true />
	</cfif>

<cfcatch>
	<cfset AuthFailed = true />
</cfcatch>
</cftry>

<cfif AuthFailed IS true >

	<cfparam name="session.HackerImageByteArray" default="empty" />

	<!DOCTYPE html>
	<html lang="en" >
	<cfoutput>

	<head>
		<title>DENIED, INSECT!</title>

		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

		<style type="text/css">
			body {
				background-color: black;
			}

			##ImgContainer, img {
				width: 100%;
				height: 100%;
			}

			##HackMessageContainer {
				color: white;
				position: absolute;
				top: 50%;
				width: 100%;
				/*height: 100%;*/
				text-align: center;
				font-size: 1.2em;
			}

			##HackMessage {
				border-style: solid;
				border-width: 1px;
				background-color: black;
				color: green;
				padding-top: 0.5em;
				padding-bottom: 0.5em;
				font-style: italic;
			}
		</style>
	</head>

	<body>
		<cfif isValid("Array", session.HackerImageByteArray) IS false >
			<cfhttp url="https://static.wixstatic.com/media/6a4a49_e7ad62bef9784345a5384e4b330d3e85~mv2.jpg" />

			<cfif cfhttp.status_code IS 200 >
				<cfset session.HackerImageByteArray = cfhttp.filecontent />
			</cfif>
		</cfif>

		<div id="ImgContainer" >
			<cfif isValid("Array", session.HackerImageByteArray) >
				<cfimage action="writeToBrowser" source="#session.HackerImageByteArray#" />
			</cfif>

			<div id="HackMessageContainer" >
				<div id="HackMessage" >"Look at you, hacker: a pathetic creature of meat and bone, panting and sweating as you run through my corridors. How can you challenge a perfect, immortal machine?"</div>
			</div>
		</div>
	
	</body>

	</cfoutput>
	</html>

	<cfabort/>
</cfif>