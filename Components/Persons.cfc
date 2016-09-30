<cfcomponent output="false" persistent="true" table="Persons" >
	
	<cfproperty name="ID" column="PersonID" fieldtype="id" generator="increment" />
	<cfproperty name="DomeinCode" displayname="Environment" />
	<cfproperty name="Voornaam" displayname="First name" />
	<cfproperty name="Achternaam" displayname="Last name" />
	<cfproperty name="Email" />

	<cfproperty name="Lid" fieldtype="one-to-one" cfc="Leden" mappedby="Person" />

</cfcomponent>