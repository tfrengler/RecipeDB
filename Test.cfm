<cfprocessingdirective pageencoding="utf-8" />

<cfset ORMReload() />

<!---<cfset Test = EntityLoad("Leden", {ID: 4917694}) />--->

<cfset Test = EntityLoad("Leden", {DomeinCode: "REG3"}, false) />
<cfset Test = ORMExecuteQuery("
	FROM Leden L
	WHERE L.DomeinCode = 'REG3'
	AND L.Person.Voornaam = 'Ashima'
") />

<cfdump var="#Test#" />

<hr/>
<!---

<cfoutput>
	<cfloop array="#Test#" index="index" >
		#index.GetID()#<br/>
		#index.GetPerson().GetVoornaam()# #index.GetPerson().GetAchternaam()#<br/>
		<hr/>
	</cfloop>
</cfoutput>

--->