<cfprocessingdirective pageencoding="utf-8" />
<cfoutput>
	
	<!--- <cfset currentDirectory = getDirectoryFromPath( getCurrentTemplatePath() ) />
	<cfset parentDirectory = ListDeleteAt(currentDirectory, ListLen(currentDirectory, "\"), "\") />
	#currentDirectory#<br/>
	#parentDirectory# --->

<!--- 	<cfset Test = createObject("component", "Models.User") />

	<cfdump var="#Test#" /> --->

	#isUserLoggedIn()#
	<cflogout>
	#isUserLoggedIn()#

</cfoutput>