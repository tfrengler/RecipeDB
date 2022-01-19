<cfcomponent output="false" modifier="abstract" persistent="true" accessors="false" hint="This is the core component for all CFCs that model unique instances of an object" >

	<cfscript>
		static {
			ValidSQLOperators = ["equal to","not equal to","begins with","ends with","contains","in","greater than","less than"];
		}
	</cfscript>

	<!--- STATIC--->

	<cffunction modifier="static" name="GetBy" returntype="query" access="public" output="false" hint="Static method. Returns a query of objects that match your column, operator and search string." >
		<cfargument name="columnToSearchOn" type="string" required="true" hint="The name of the column you want to search on." />
		<cfargument name="searchOperator" type="string" required="true" hint="The search operator you want to use (such as equal to, begins with, contains etc)." />
		<cfargument name="searchData" type="any" required="true" hint="The data you're searching on. Can be a date, float, integer or a string. NOTE: For IN-searches you don't have to put parentheses around the values!" />

		<cfset var Columns = "#static.TableKey#,#static.TableColumns#" />
		<cfset var GetByObjectData = null />
		<cfset var Qualifier = null />
		<cfset var QueryString = null />

		<cfif arrayFind(static.ValidSQLOperators, arguments.searchOperator) IS 0 >
			<cfthrow message="Error when getting data for object" detail="The search operator you passed as '#arguments.SearchOperator#' is not valid. Valid operators are: #arrayToList(static.ValidSQLOperators)#" />
		</cfif>

		<cfif listFindNoCase(Columns, arguments.columnToSearchOn) IS 0 >
			<cfthrow message="Error when getting data for object" detail="The search column you passed as '#arguments.ColumnToSearchOn#' is not valid. Valid columns are: #Columns#" />
		</cfif>

		<cfswitch expression=#arguments.searchOperator# >

			<cfcase value="equal to" >
				<cfset Qualifier = "=" >
				<cfset QueryString = arguments.searchData />
			</cfcase>

			<cfcase value="not equal to" >
				<cfset Qualifier = "!=" >
				<cfset QueryString = arguments.searchData />
			</cfcase>

			<cfcase value="begins with" >
				<cfset Qualifier = "LIKE" >
				<cfset QueryString = "#arguments.searchData#%" />
			</cfcase>

			<cfcase value="ends with" >
				<cfset Qualifier = "LIKE" >
				<cfset QueryString = "%#arguments.searchData#" />
			</cfcase>

			<cfcase value="contains" >
				<cfset Qualifier = "LIKE" >
				<cfset QueryString = "%#arguments.searchData#%" />
			</cfcase>

			<cfcase value="in" >
				<cfset Qualifier = "IN" >
				<cfset QueryString = "(#arguments.searchData#)" />
			</cfcase>

			<cfcase value="greater than" >
				<cfset Qualifier = ">" >
				<cfset QueryString = arguments.SearchData />
			</cfcase>

			<cfcase value="less than" >
				<cfset Qualifier = "<" >
				<cfset QueryString = arguments.SearchData />
			</cfcase>

			<cfdefaultcase>
				<cfthrow message="Error enumerating search operator" detail="This shouldn't happen..." />
			</cfdefaultcase>
		</cfswitch>

		<cfquery name="GetByObjectData" >

			SELECT #Columns#
			FROM '#variables.TableName#'

			<cfif	isValid("integer", arguments.SearchData)
				OR	IsValid("date", arguments.SearchData)
				OR	IsValid("float", arguments.SearchData)
				OR	Qualifier is "IN"
			>

			WHERE #arguments.ColumnToSearchOn# #Qualifier# #QueryString#;

			<cfelseif isValid("string", arguments.SearchData) >

			WHERE #arguments.ColumnToSearchOn# #Qualifier# '#QueryString#';

			<cfelse>
				<cfthrow message="Error when fetching data" detail="The search string column you passed as '#arguments.ColumnToSearchOn#' is not a valid float, date, integer or string" />
			</cfif>
		</cfquery>

		<cfreturn GetByObjectData />
	</cffunction>

	<cffunction modifier="static" name="GetData" returntype="query" access="public" output="false" hint="Static method. Fetch data from a specific object or multiple objects." >
		<cfargument name="columnList" type="string" required="false" default="" hint="List of columns you want to fetch data from." />
		<cfargument name="id" type="numeric" required="false" default="0" hint="ID of the object you want to fetch data for. If you leave this out you get all objects." />

		<cfset var ObjectData = null />
		<cfset var CurrentColumn = "" />
		<cfset var Columns = "" />
		<cfset var TableColumns = "#static.TableKey#,#static.TableColumns#" />

		<cfif len(arguments.ColumnList) GT 0 >

			<cfloop list="#arguments.ColumnList#" index="CurrentColumn" >
				<cfif listFindNoCase(TableColumns, CurrentColumn) IS 0 >
					<cfthrow message="The column '#CurrentColumn#' you are trying to get data for is not a valid column in the #static.TableName#-table. Valid columns are: #static.TableColumns#" />
				</cfif>
			</cfloop>

			<cfset Columns = arguments.ColumnList />
		<cfelse>
			<cfset Columns = TableColumns />
		</cfif>

		<cfset ObjectData = null />

		<cfquery name="ObjectData" >
			SELECT #Columns#
			FROM #static.TableName#
			<cfif arguments.ID GT 0 >
			WHERE #static.TableKey# = <cfqueryparam sqltype="INT" value=#arguments.ID# />
			</cfif>
		</cfquery>

		<cfreturn ObjectData />
	</cffunction>

	<cffunction modifier="static" name="Exists" returntype="boolean" access="public" output="false" hint="" >
		<cfargument name="ID" type="numeric" required="true" hint="" />

		<cfset var ExistenceCheck = null />

		<cfquery name="ExistenceCheck" >
			SELECT #static.TableKey#
			FROM #static.TableName#
			WHERE #static.TableKey# = <cfqueryparam sqltype="INT" value=#arguments.ID# />
		</cfquery>

		<cfreturn ExistenceCheck.RecordCount IS 1 />
	</cffunction>

	<!--- INSTANCE --->

	<cffunction name="Delete" returntype="void" access="public" output="false" hint="Delete the db data belonging to this object instance" >

		<cftransaction action="begin" >
			<cftry>
				<cfquery>
					DELETE
					FROM #static.TableName#
					WHERE #static.TableKey# = <cfqueryparam sqltype="INT" value="#variables["Get#static.TableKey#"]()#" />
				</cfquery>

				<cfset structClear(this) />
				<cftransaction action="commit" />

				<cfcatch>

					<cftransaction action="rollback" />
					<cfthrow object="#cfcatch#" />

				</cfcatch>
			</cftry>
		</cftransaction>
	</cffunction>

</cfcomponent>