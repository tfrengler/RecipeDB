<cfprocessingdirective pageencoding="utf-8" />

<cfset Recipe = createObject("component", "Components.Recipe") />

<cfset Test = Recipe.init(ID=4) />

<!--- <cfset Test.setDateTimeLastModified( Date=createODBCDateTime(now()) ) /> --->

<!--- <cfset Test.save() /> --->

<cfoutput>
	#Test.getRecipeID()#<br/>
	#Test.getDateCreated()#<br/>
	#Test.getDateTimeLastModified()#<br/>
	#Test.getCreatedByUser()#<br/>
	#Test.getLastModifiedByUser()#<br/>
	#arrayToList(Test.getComments())#<br/>
	#Test.getIngredients()#<br/>
	#Test.getDescription()#<br/>
	#Test.getPicture()#<br/>
	#Test.getInstructions()#<br/>
</cfoutput>

<!--- <cftransaction>
	<cfquery name="NewUser" datasource="test" >
		INSERT INTO Users (
			DateCreated,
			DateLastLogin,
			SessionID
		)
		VALUES (
			<cfqueryparam sqltype="CF_SQL_DATE" value="#createODBCDate(now())#" />,
			<cfqueryparam sqltype="CF_SQL_TIMESTAMP" value="#createODBCDateTime(now())#" />,
			<cfqueryparam sqltype="CF_SQL_OTHER" value="#createUUID()#" />
		)
	</cfquery>
</cftransaction> --->