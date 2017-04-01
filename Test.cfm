<cfprocessingdirective pageencoding="utf-8" />

<cfset User = createObject("component", "Components.User") />

<cfset Test1 = createObject("component", "Components.User").init(
	ID=3,
	Datasource="dev") 
/>

<cfset Test1.changePassword(
	SecurityManager=createObject("component", "Components.SecurityManager")
) />

<cfdump var="#Test1.getPassword()#" />
<cfdump var="#Test1.getTempPassword()#" />

<!--- <cfset Test1.save() /> --->

<!--- <cfset Test1.setUserName(Name="TestUser1") />
<cfset Test1.setDisplayName(Name="Katja") />
<cfset Test1.setBrowserLastUsed(UserAgentString="Firefox") />
<cfset Test1.setBlocked(Blocked=false) />
<cfset Test1.save() />

<cfset Test2 = createObject("component", "Components.User").init(ID=4) />

<cfset Test2.setUserName(Name="TestUser2") />
<cfset Test2.setDisplayName(Name="Thomas") />
<cfset Test2.setBrowserLastUsed(UserAgentString="Chrome") />
<cfset Test2.setBlocked(Blocked=true) />
<cfset Test2.save() />

<cfset Test3 = createObject("component", "Components.User").init(ID=5) />

<cfset Test3.setUserName(Name="TestUser3") />
<cfset Test3.setDisplayName(Name="Carlette") />
<cfset Test3.setBrowserLastUsed(UserAgentString="Explorer") />
<cfset Test3.setBlocked(Blocked=false) />
<cfset Test3.save() />

<cfset Test4 = createObject("component", "Components.User").init(ID=6) />

<cfset Test4.setUserName(Name="TestUser4") />
<cfset Test4.setDisplayName(Name="Maarten") />
<cfset Test4.setBrowserLastUsed(UserAgentString="Opera") />
<cfset Test4.setBlocked(Blocked=true) />
<cfset Test4.save() /> --->

<!--- <cfdump var="#User.getUserID()#" />
<cfdump var="#User.getDateCreated()#" />
<cfdump var="#User.getDateTimeLastLogin()#" />
<cfdump var="#User.getPassword()#" />
<cfdump var="#User.getTempPassword()#" />
<cfdump var="#User.getUserName()#" />
<cfdump var="#User.getDisplayName()#" />
<cfdump var="#User.getTimesLoggedIn()#" />
<cfdump var="#User.getBrowserLastUsed()#" />
<cfdump var="#User.getBlocked()#" />
<cfdump var="#User.getTableName()#" />
<cfdump var="#User.getTableKey()#" />
<cfdump var="#User.getTableColumns()#" /> --->

<!--- <cfset Test.setDateTimeLastModified( Date=createODBCDateTime(now()) ) /> --->

<!---

*getUserID
*getDateCreated
*getDateTimeLastLogin
*getPassword
*getTempPassword
*getUserName
*getDisplayName
*getTimesLoggedIn
*getBrowserLastUsed
*getBlocked
*getTableName
*getTableKey
*getTableColumns

setUserID
setDateCreated
setDateTimeLastLogin
setPassword
setTempPassword
setUserName
setDisplayName
setTimesLoggedIn
setBrowserLastUsed
setBlocked

changePassword
delete
onLogin
exists
save
create
load
init

--->

<hr/>

<cfquery name="TestQ" datasource="dev" >
	SELECT *
	FROM Users
</cfquery>

<cfdump var="#TestQ#" />