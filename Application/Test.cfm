<cfprocessingdirective pageencoding="utf-8" />
<cfoutput>
	
	<!--- <cfset currentDirectory = getDirectoryFromPath( getCurrentTemplatePath() ) />
	<cfset parentDirectory = ListDeleteAt(currentDirectory, ListLen(currentDirectory, "\"), "\") />
	#currentDirectory#<br/>
	#parentDirectory# --->

<!--- 	<cfset Test = createObject("component", "Models.User") />--->

	<!--- <cfdump var="#session.CurrentUser.getUserID()#" abort="true" /> --->

	<cfset RecipeInterface = createObject("component", "Models.Recipe").init(
		ID=4,
		Datasource=application.Settings.Datasource
	) />

	<cfdump var="#RecipeInterface.getCreatedByUser()#" />

<!--- 	<cfset RecipeInterface.createNew(
		UserID=session.CurrentUser.getUserID(),
		Name="Test recipe 1",
		Datasource=application.Settings.Datasource
	) />

	<cfset RecipeInterface.createNew(
		UserID=session.CurrentUser.getUserID(),
		Name="Test recipe 2",
		Datasource=application.Settings.Datasource
	) />

	<cfset RecipeInterface.createNew(
		UserID=session.CurrentUser.getUserID(),
		Name="Test recipe 3",
		Datasource=application.Settings.Datasource
	) /> --->

</cfoutput>