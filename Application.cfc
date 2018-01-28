<cfcomponent output="false">
<cfprocessingdirective pageencoding="utf-8" />

	<cfset this.name="RecipeDB" />
	<cfset this.applicationtimeout = CreateTimeSpan(1,0,0,0) />
	<cfset this.sessionmanagement = true />
	<cfset this.sessiontimeout = CreateTimeSpan(0,0,35,0) />
	<cfset this.loginstorage = "session" />
	<cfset this.setClientCookies = true />
	<cfset this.scriptProtect = "all" />

	<!--- MAPPINGS --->

	<cfset this.root = getDirectoryFromPath( getCurrentTemplatePath() ) />
	<cfset this.appdirectory = this.root & "Application\" /> 
	
	<cfset this.mappings["/Models"] = (this.appdirectory & "Models/") />
	<cfset this.mappings["/Components"] = (this.appdirectory & "Components/") />
	<cfset this.mappings["/Assets"] = (this.appdirectory & "Assets/") />
	<cfset this.mappings["/Views"] = (this.appdirectory & "Views/") />
	<cfset this.mappings["/Controllers"] = (this.appdirectory & "Controllers/") />

	<cffunction name="onApplicationStart" returnType="boolean" output="false">

		<cfset var configXML = "" />
		<cfset var queryListOfControllers = queryNew("") />
		<cfset application.allowedAJAXControllers = "" />

		<!--- Set up paths based on config file --->
		<cffile action="read" file="Application/Assets/config.xml" charset="utf-8" variable="configXML" accept="application/xml" />
		<cfset configXML = xmlParse(configXML) />

		<cfif directoryExists(configXML.envelope.files.patchnotes.xmlText) >
			<cfset application.settings.files.patchnotes = configXML.envelope.files.patchnotes.xmlText />
		<cfelse>
			<cfthrow message="Error setting up the application" detail="Patchnote directory '#settings.files.patchnotes#' does not exist!" />
		</cfif>

		<cfif directoryExists(configXML.envelope.files.roadmap.xmlText) >
			<cfset application.settings.files.roadmap = configXML.envelope.files.roadmap.xmlText />
		<cfelse>
			<cfthrow message="Error setting up the application" detail="Roadmap directory '#settings.files.roadmap#' does not exist!" />
		</cfif>

		<cfif directoryExists(configXML.envelope.files.recipe_pictures.xmlText) >
			<cfset application.settings.files.recipe.standard = configXML.envelope.files.recipe_pictures.xmlText />
		<cfelse>
			<cfthrow message="Error setting up the application" detail="Recipe picture directory '#settings.files.recipe.standard#' does not exist!" />
		</cfif>

		<cfif directoryExists(configXML.envelope.files.recipe_thumbnails.xmlText) >
			<cfset application.settings.files.recipe.thumbnails = configXML.envelope.files.recipe_thumbnails.xmlText />
		<cfelse>
			<cfthrow message="Error setting up the application" detail="Recipe thumbnail directory '#settings.files.recipe.thumbnails#' does not exist!" />
		</cfif>

		<cfif directoryExists(configXML.envelope.files.temp_folder.xmlText) >
			<cfset application.settings.files.temp = configXML.envelope.files.temp_folder.xmlText />
		<cfelse>
			<cfthrow message="Error setting up the application" detail="Temp directory '#configXML.envelope.files.temp_folder.xmlText#' does not exist!" />
		</cfif>

		<cfset application.settings.datasource = "dev" />

		<!--- Set up singletons --->
		<cfif structKeyExists(application, "securityManager") IS false >
			<cfset application.securityManager = createObject("component", "Components.SecurityManager") />
		</cfif>

		<cfif structKeyExists(application, "fileManager") IS false >
			<cfset application.fileManager = createObject("component", "Components.FileManager").init(
					recipePicturePath = application.settings.files.recipe.standard,
					recipeThumbnailPath = application.settings.files.recipe.thumbnails,
					tempDirectory = application.settings.files.temp
			) />
		</cfif>

		<!--- SETTING UP ALLOWED AJAX PROXY CFC TARGETS --->
		<cfdirectory directory="/Controllers" action="list" filter="*.cfc" listinfo="name" name="queryListOfControllers" >

		<cfloop query=#queryListOfControllers# >
			<cfset application.allowedAJAXControllers = listAppend(application.allowedAJAXControllers, queryListOfControllers.name) />
		</cfloop>

		<cfreturn true />
	</cffunction>

	<cffunction name="onRequestStart" returnType="boolean" output="false" >
		<cfargument type="string" name="targetPage" required=true />

		<!--- For force refreshing static content programmatically, rather than using Shift + F5 or similar means --->
		<cfif structKeyExists(URL, "Refresh") >
			<cfheader name="Cache-Control" value="no-cache, no-store, must-revalidate" />
			<cfheader name="Pragma" value="no-cache" />
			<cfheader name="Expires" value="0" />
		</cfif>

		<!--- For testing purposes, this nukes the session and restarts the application --->
		<cfif structKeyExists(URL, "Restart") >

			<cfset sessionInvalidate() />
			<cfset applicationStop() />
			<cflocation url="http://#CGI.SERVER_NAME#/Login.cfm" addtoken="false" />

		</cfif>

		<cfif find("/Toolbox/", arguments.targetPage) GT 0 >
			<cfreturn true />
		</cfif>

		<!--- 
			Make a request, if it's targeting the login page and the form-scope is empty
			(meaning no login request has been made), then we check if the current user
			is already logged in. If he/she isn't then we log them out and kill their session
			so that a new one is created. We also do a return so that cflogin does not trigger
		--->
		<cfif listFindNoCase("/Login.cfm,/index.cfm", arguments.targetPage) GT 0 AND structIsEmpty(form) >

			<cfif isUserLoggedIn() >
				<cflogout />
			</cfif>
			<cfreturn true />

		</cfif>

		<!--- LOGIN/AUTHENTICATION PROCESS --->
		<cflogin applicationtoken="RecipeDB" idletimeout="1800" >
			<!--- 
				The body of cflogin is executed if the current user is not logged in, otherwise it's skipped completely.
				This latter what we want to happen everytime a request is made in the system after they are logged in.
			--->

			<!---
				If these keys do not exist in the form-scope it means no login attempt was made and being this far into
				the code means it came from a request that didn't target the login-page, thus we redirect them back.
			--->
			<cfif structKeyExists(form, "j_username") IS false AND structKeyExists(form, "j_password") IS false >
				<cflocation url="http://#CGI.SERVER_NAME#/Login.cfm?Reason=5" addtoken="false" />
			</cfif>

			<cfset var UserInterface = createObject("component", "Models.User") />
			<cfset var UserID = 0 />
			<cfset var UserSearch = queryNew("") />
			<cfset var LoggedInUser = "" />

			<cfset UserSearch = UserInterface.getBy( 
				ColumnToSearchOn="UserName",
				SearchOperator="equal to",
				SearchData=form.j_username,
				Datasource="#application.Settings.Datasource#"
			) />

			<cfif UserSearch.RecordCount IS 1 >
				<cfset LoggedInUser = createObject("component", "Models.User").init(
					ID=UserSearch[ UserInterface.getTableKey() ],
					Datasource="#application.Settings.Datasource#"
				) />

			<cfelseif UserSearch.RecordCount IS 0 >
				<cflocation url="Login.cfm?Reason=1" addtoken="false" />
				<!--- User name does not exist/is incorrect --->

			<cfelseif UserSearch.RecordCount GT 1 >
				<cflocation url="Login.cfm?Reason=2" addtoken="false" />
				<!--- There's more than one record with this username --->
			</cfif>

			<cfif LoggedInUser.validatePassword( Password=form.j_password, SecurityManager=application.securityManager ) IS false >
				<cflocation url="Login.cfm?Reason=3" addtoken="false" />
				<!--- Password is incorrect ---> 
			</cfif>

			<cfif LoggedInUser.getBlocked() IS 1 >
				<cflocation url="Login.cfm?Reason=4" addtoken="false" />
				<!--- User account is blocked ---> 
			</cfif>

			<cfif LoggedInUser.getUserName() IS "tfrengler" >
				<cfloginuser name="#LoggedInUser.getUserName()#" password="#LoggedInUser.getPassword()#" roles="Admin" />
			<cfelse>
				<cfloginuser name="#LoggedInUser.getUserName()#" password="#LoggedInUser.getPassword()#" roles="User" />
			</cfif>

			<cfset LoggedInUser.updateLoginStats(
				UserAgentString=cgi.http_user_agent
			) />
			<cfset LoggedInUser.save() />

			<cflock timeout="5" scope="Session" throwontimeout="true" >
				<cfset session.currentUser = LoggedInUser />
				<cfset session.authKey = application.securityManager.generateAuthKey() />
			</cflock>

			<cflocation url="Application/index.cfm" addtoken="false" />
		</cflogin>

		<cfreturn true />
	</cffunction>

	<cffunction name="onSessionEnd" returntype="boolean" output="false">

		<cfcookie name="CFID" value="" expires="NOW" />
		<cfcookie name="CFTOKEN" value="" expires="NOW" />
		<cfset sessionInvalidate() />
		
		<cfreturn true />
		
	</cffunction>
</cfcomponent>