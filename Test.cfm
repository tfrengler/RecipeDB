<cfprocessingdirective pageencoding="utf-8" />
<cfoutput>
	
	<!--- <cfset currentDirectory = getDirectoryFromPath( getCurrentTemplatePath() ) />
	<cfset parentDirectory = ListDeleteAt(currentDirectory, ListLen(currentDirectory, "\"), "\") />
	#currentDirectory#<br/>
	#parentDirectory# --->

 	<cfset UserInterface = createObject("component", "Models.User") />

 	<cfset NewUser = UserInterface.create(
 		Username="gnarglefargle",
 		Datasource=application.Settings.Datasource
 	) />

 	<!--- <cfset NewUser = createObject("component", "Models.User").init(
 		ID=10,
 		Datasource=application.Settings.Datasource
 	) /> --->

<!---  	<cfset NewUser.changePassword(
 		SecurityManager=createObject("component", "Models.SecurityManager"),
		Password="tf499985"
 	) /> --->

 	<!--- <cfset NewUser.setBlocked(Blocked=false) /> --->

 	<!--- <p>#NewUser.getPassword()#</p>
 	<p>#NewUser.getPasswordSalt()#</p> --->
	<p>#NewUser.getDisplayName()#</p>
	<p>#NewUser.getUserName()#</p>

 	<!--- <cfset NewUser.save() /> --->

<!---  	<cfset User = createObject("component", "Models.User").init(
 		ID=10,
 		Datasource=application.Settings.Datasource
 	) />

 	#User.validatePassword(
 		Password="tf499985",
 		SecurityManager=createObject("component", "Models.SecurityManager")
 	)# --->
</cfoutput>