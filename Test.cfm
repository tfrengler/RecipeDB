<cfprocessingdirective pageencoding="utf-8" />
<cfoutput>

<cfset Test = createObject("component", "Models.User").init(ID=4,Datasource=application.settings.datasource) />

<cfdump var="#Test.getUsername()#" />

<cfset Test.setBlocked(Blocked=false) />
<cfset Test.save() />

</cfoutput>