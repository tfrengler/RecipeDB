<cfcomponent output="false" hint="A singleton component meant to live in the Application-scope, designed to encapsulate application level settings and methods for setting and grabbing them." >
<cfprocessingdirective pageEncoding="utf-8"  />

	<cfset Language = "en" />
	<!--- <cfset Datasource="" /> --->

	<cffunction name="init" access="public" output="false" hint="" >
		
	</cffunction>

	<cffunction name="validateAuthKey" returntype="boolean" access="public" hint="" >
		<cfargument name="Key" type="string" required="true" hint="" />
		
		<cfif variables.AuthKey IS arguments.Key >
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>

	<cffunction name="getDatasource" returntype="string" access="public" hint="" >
		
		<cfreturn variables.Datasource />
	</cffunction>

</cfcomponent>