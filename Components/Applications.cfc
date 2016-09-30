<cfcomponent output="true" persistent="true" table="Applications" indexable="true" >
	
	<cfproperty name="ID" column="ApplicationID" fieldtype="id" generator="increment" />
	<cfproperty name="DomeinCode" />
	<cfproperty name="ApplicationMotivation" />
	<cfproperty name="VacatureID" />
	<cfproperty name="LastWorkflowStatusID" />

	<cfproperty name="Candidate" fieldtype="many-to-one" cfc="Leden" />

</cfcomponent>