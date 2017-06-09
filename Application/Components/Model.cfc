<cfcomponent output="false" >
<cfprocessingdirective pageEncoding="utf-8" />

	<!--- This is the core component for all CFCs that model unique instances of an object --->

	<cfset IsStatic = true />
	<cfset DatasourceName = "" />

	<!--- Define these in the child CFC

	<cfset TableName = "" /> The table name this component models its data on
	<cfset TableKey = "" /> The primary key of the table
	<cfset TableColumns = "" /> Comma delimited list of all the table columns but without the primary key

	--->

	<cffunction name="setDataSource" access="private" output="false" hint="" >
		<cfargument name="Name" type="string" required="true" hint="" />

		<cfset variables.DatasourceName = arguments.Name />
	</cffunction>

	<cffunction name="getDatasource" access="public" returntype="string" output="false" hint="" >
		<cfreturn variables.DatasourceName />
	</cffunction>

	<!--- Table mappings --->

	<cffunction name="getTableName" returntype="string" access="public" output="false" hint="" >
		<cfreturn TableName />
	</cffunction> 

	<cffunction name="getTableKey" returntype="string" access="public" output="false" hint="" >
		<cfreturn TableKey />
	</cffunction>

	<cffunction name="getTableColumns" returntype="string" access="public" output="false" hint="" >
		<cfreturn TableColumns />
	</cffunction>

	<!--- Static method support --->

	<cffunction name="onStatic" returntype="void" access="private" output="false" hint="" >
		<cfif variables.IsStatic >
			<cfthrow message="Can't call this method because the instance is not initialized" />
		</cfif>
	</cffunction>

	<cffunction name="onInitialized" returntype="void" access="private" output="false" hint="" >
		<cfif variables.IsStatic IS false >
			<cfthrow message="Can't call this static method because this instance is already initialized" />
		</cfif>
	</cffunction>

</cfcomponent>