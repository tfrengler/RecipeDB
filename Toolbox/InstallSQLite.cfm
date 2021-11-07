<cfinclude template="CheckAuth.cfm" />

<!DOCTYPE html>
<html lang="en" >
<cfoutput>

<head>
	<title>Toolbox: SQLite</title>

	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
</head>

<body>
	<p><a href="index.cfm" >Back to Toolbox</a></p>
	<h1>Install SQLite</h1>

    <cfadmin
        type="server"
        password="tf499985"
        action="getBundles"
        returnvariable="bundles" />

    <cfquery dbtype="query" name="SQLiteSearch" >
        SELECT *
        FROM bundles
        WHERE title = 'SQLite JDBC'
        -- AND state = 'installed'
    </cfquery>

    <cfif SQLiteSearch.recordCount GT 0 >
        <p>SQLite appears to be installed:</p>
        <cfdump var=#SQLiteSearch# />

    <cfelse>
        <p>SQLite appears not to be installed, attempting to do so now...</p>

        <cfset Root = getDirectoryFromPath( getCurrentTemplatePath() ) />
        <cfset DbLibFile = "#Root#\sqlite-jdbc-3.36.0.3.jar" /> <!--- https://bitbucket.org/xerial/sqlite-jdbc/downloads/ --->

        <cfset CFMLEngine = createObject( "java", "lucee.loader.engine.CFMLEngineFactory" ).getInstance() />
        <cfset OSGiUtil = createObject( "java", "lucee.runtime.osgi.OSGiUtil" ) />
        <cfset resource = CFMLEngine.getResourceUtil().toResourceExisting( getPageContext(), DbLibFile ) />

        <cfset OSGiUtil.installBundle(
            CFMLEngine.getBundleContext(),
            resource,
            true
        ) />

        <p>Done</p>
    </cfif>
</body>

</cfoutput>
</html>