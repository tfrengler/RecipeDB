<cfcomponent output="false" persistent="true" table="Leden" >
	
	<cfproperty name="ID" column="LidID" fieldtype="id" generator="increment" ormType="int" />
	<cfproperty name="DomeinCode" fieldtype="column" ormType="string" />
	<cfproperty name="MatchCode" fieldtype="column" ormType="int" />
	<cfproperty name="UploadCVID" fieldtype="column" ormType="string" />
	<cfproperty name="LastWorkflowStatusID" fieldtype="column" ormType="int" />
	<cfproperty name="Archief" fieldtype="column" ormType="boolean" />

	<cfproperty 
		name="Person" 
		fieldtype="one-to-one" 
		cfc="Persons"
		fkcolumn="PersonID"
		inverse="true"
	/> 

	<cfproperty 
		name="Applications" 
		singularname="Application" 
		type="struct" 
		structkeycolumn="ApplicationID" 
		fieldtype="one-to-many" 
		cfc="Applications" 
		fkcolumn="LidID" 
		inverse="true"
	/>
</cfcomponent>