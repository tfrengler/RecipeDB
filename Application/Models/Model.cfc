<cfcomponent output="false" >
<cfprocessingdirective pageEncoding="utf-8" />

	<!--- This is the core component for all CFCs that model unique instances of an object --->

	<cfset IsStatic = true />
	<cfset DatasourceName = "" />
	<cfset TableKey = "" />
	<cfset TableColumns = "" />

	<!--- Define these in the child CFC

	<cfset TableName = "" /> The table name this component models its data on
	<cfset TableKey = "" /> The primary key of the table
	<cfset TableColumns = "" /> Comma delimited list of all the table columns without the primary key

	When adding new DB columns to a model don't forget to:
	- Add the variable at the top with a blank default value
	- Add getter and setter methods as appropriate
	- Add them to load(), save() and TableColumns
	- Add them to any other methods if needed

	--->

	<cffunction name="setupTableColumns" access="private" returntype="void" output="false" hint="" >
		<cfargument name="Datasource" type="string" required="true" hint="The name of the datasource to use for queries." />

		<cfif len(variables.getTableColumns()) GT 0 AND len(variables.getTableKey()) GT 0 >
			<cfreturn />
		</cfif>

		<cfset var ColumnDataFromDB = "" />
		<cfset var ListOfColumns = "" />

		<cfdbinfo name="ColumnDataFromDB" datasource="#arguments.Datasource#" type="columns" table="#getTableName()#" />

		<cfloop query="#ColumnDataFromDB#" >
			<cfif ColumnDataFromDB.IS_PRIMARYKEY IS false >

				<cfset ListOfColumns = listAppend(ListOfColumns, ColumnDataFromDB.COLUMN_NAME) />

			<cfelseif ColumnDataFromDB.IS_PRIMARYKEY IS true >
				<!--- This is predicated on our db structure being so that we only ever have one primary key of course --->
				<cfif len(variables.getTableKey()) IS 0 >
					<cfset variables.TableKey = ColumnDataFromDB.COLUMN_NAME />
				</cfif>
			</cfif>
		</cfloop>

		<cfset variables.TableColumns = ListOfColumns />
	</cffunction>

	<cffunction name="setDataSource" access="private" returntype="void" output="false" hint="" >
		<cfargument name="Name" type="string" required="true" hint="" />

		<cfset variables.DatasourceName = arguments.Name />
	</cffunction>

	<cffunction name="getDatasource" access="public" returntype="string" output="false" hint="" >
		<cfreturn variables.DatasourceName />
	</cffunction>

	<!--- Table mappings --->

	<cffunction name="getTableName" returntype="string" access="public" output="false" hint="" >
		<cfreturn variables.TableName />
	</cffunction> 

	<cffunction name="getTableKey" returntype="string" access="public" output="false" hint="" >
		<cfreturn variables.TableKey />
	</cffunction>

	<cffunction name="getTableColumns" returntype="string" access="public" output="false" hint="" >
		<cfreturn variables.TableColumns />
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

	<!--- Shared methods --->

	<cffunction name="getBy" returntype="query" access="public" output="false" hint="Static method. Returns a query of objects that match your column, operator and search string." >
		<cfargument name="ColumnToSearchOn" type="string" required="true" hint="The name of the column you want to search on." />
		<cfargument name="SearchOperator" type="string" required="true" hint="The search operator you want to use (such as equal to, begins with, contains etc)." />
		<cfargument name="SearchData" type="any" required="true" hint="The data you're searching on. Can be a date, float, integer or a string. NOTE: For IN-searches you don't have to put parentheses around the values!" />
		<cfargument name="Datasource" type="string" required="true" hint="The name of the datasource to use for queries." />

		<cfset variables.onInitialized() />
		<cfset variables.setupTableColumns( Datasource=arguments.Datasource ) />

		<cfset var ObjectData = queryNew("") />
		<cfset var CurrentColumn = "" />
		<cfset var Columns = "#getTableKey()#,#getTableColumns()#" />
		<cfset var ValidOperators = "equal to,not equal to,begins with,ends with,contains,in,greater than,less than" />
		<cfset var Qualifier = "" />
		<cfset var QueryString = "" />

		<cfif listFindNoCase(ValidOperators, arguments.SearchOperator) IS 0 >
			<cfthrow message="Error when searching for users" detail="The search operator you passed as '#arguments.SearchOperator#' is not valid. Valid operators are: #ValidOperators#" />
		</cfif>

		<cfif listFindNoCase(Columns, arguments.ColumnToSearchOn) IS 0 >
			<cfthrow message="Error when searching for users" detail="The search column you passed as '#arguments.ColumnToSearchOn#' is not valid. Valid columns are: #Columns#" />
		</cfif>

		<cfswitch expression="#arguments.SearchOperator#" >

			<cfcase value="equal to" >
				<cfset Qualifier = "=" >
				<cfset QueryString = arguments.SearchData />
			</cfcase>

			<cfcase value="not equal to" >
				<cfset Qualifier = "!=" >
				<cfset QueryString = arguments.SearchData />
			</cfcase>

			<cfcase value="begins with" >
				<cfset Qualifier = "LIKE" >
				<cfset QueryString = "#arguments.SearchData#%" />
			</cfcase>

			<cfcase value="ends with" >
				<cfset Qualifier = "LIKE" >
				<cfset QueryString = "%#arguments.SearchData#" />
			</cfcase>

			<cfcase value="contains" >
				<cfset Qualifier = "LIKE" >
				<cfset QueryString = "%#arguments.SearchData#%" />
			</cfcase>

			<cfcase value="in" >
				<cfset Qualifier = "IN" >
				<cfset QueryString = "(#arguments.SearchData#)" />
			</cfcase>

			<cfcase value="greater than" >
				<cfset Qualifier = ">" >
				<cfset QueryString = arguments.SearchData />
			</cfcase>

			<cfcase value="less than" >
				<cfset Qualifier = "<" >
				<cfset QueryString = arguments.SearchData />
			</cfcase>		

		</cfswitch>

		<cfquery name="ObjectData" datasource="#arguments.Datasource#" >
			SELECT #Columns#
			FROM #getTableName()#
				
			<cfif 	isValid("integer", arguments.SearchData)
				OR IsValid("date", arguments.SearchData)
				OR IsValid("float", arguments.SearchData)
				OR Qualifier is "IN"
			> 

			WHERE #arguments.ColumnToSearchOn# #Qualifier# #QueryString#;

			<cfelseif isValid("string", arguments.SearchData) >

			WHERE #arguments.ColumnToSearchOn# #Qualifier# '#QueryString#';

			<cfelse>
				<cfthrow message="Error when searching for users" detail="The search string column you passed as '#arguments.ColumnToSearchOn#' is not a valid float, date, integer or string" />
			</cfif>
		</cfquery>

		<cfreturn ObjectData />
	</cffunction>

	<cffunction name="getData" returntype="query" access="public" output="false" hint="Static method. Fetch data from a specific object or multiple objects." >
		<cfargument name="ColumnList" type="string" required="false" default="" hint="List of columns you want to fetch data from." />
		<cfargument name="ID" type="numeric" required="false" default="0" hint="ID of the object you want to fetch data for. If you leave this out you get all objects." />
		<cfargument name="Datasource" type="string" required="true" hint="The name of the datasource to use for queries." />

		<cfset variables.onInitialized() />
		<cfset variables.setupTableColumns( Datasource=arguments.Datasource ) />

		<cfset var ObjectData = queryNew("") />
		<cfset var CurrentColumn = "" />
		<cfset var Columns = "" />

		<cfif len(arguments.ColumnList) GT 0 >

			<cfloop list="#arguments.ColumnList#" index="CurrentColumn" >
				<cfif listFindNoCase("#getTableKey()#,#getTableColumns()#", CurrentColumn) IS 0 >
					<cfthrow message="The column '#CurrentColumn#' you are trying to get data for is not a valid column in the #getTableName()#-table. Valid columns are: #getTableColumns()#" />
				</cfif>
			</cfloop>

			<cfset Columns = arguments.ColumnList />
		<cfelse>
			<cfset Columns = "#getTableKey()#,#getTableColumns()#" />
		</cfif>

		<cfquery name="ObjectData" datasource="#arguments.Datasource#" >
			SELECT #Columns#
			FROM #getTableName()#
			<cfif arguments.ID GT 0 >
			WHERE #getTableKey()# = <cfqueryparam sqltype="BIGINT" value="#arguments.ID#" />
			</cfif>
		</cfquery>

		<cfreturn ObjectData />
	</cffunction>

	<cffunction name="delete" returntype="boolean" access="public" output="false" hint="Delete the db data belonging to this object instance" >
		<cfset variables.onStatic() />

		<cftransaction action="begin" >
			<cftry>
				<cfquery datasource="#variables.getDatasource()#" >
					DELETE
					FROM #variables.getTableName()#
					WHERE #variables.getTableKey()# = <cfqueryparam sqltype="BIGINT" value="#variables.getID()#" />
				</cfquery>

				<cftransaction action="commit" />

				<cfcatch>

					<cftransaction action="rollback" />
					<cfthrow object="#cfcatch#" />
					<cfreturn false />

				</cfcatch>
			</cftry>
		</cftransaction>

		<cfset variables.IsStatic = true />
		<cfreturn true />
	</cffunction>

	<cffunction name="exists" returntype="boolean" access="private" output="false" hint="" >
		<cfargument name="ID" type="numeric" required="true" hint="" />
		<cfargument name="Datasource" type="string" required="true" hint="The name of the datasource to use for queries." />

		<cfset variables.onInitialized() />
		<cfset variables.setupTableColumns( Datasource=arguments.Datasource ) />

		<cfset var ExistenceCheck = queryNew("") />
		<cfquery name="ExistenceCheck" datasource="#arguments.Datasource#" >
			SELECT #variables.getTableKey()#
			FROM #variables.getTableName()#
			WHERE #variables.getTableKey()# = <cfqueryparam sqltype="CF_SQL_BIGINT" value="#arguments.ID#" />
		</cfquery>

		<cfif ExistenceCheck.RecordCount IS 1 >
			<cfreturn true />
		</cfif>

		<cfreturn false />
	</cffunction>

</cfcomponent>