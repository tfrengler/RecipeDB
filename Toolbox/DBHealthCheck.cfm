<cfinclude template="CheckAuth.cfm" />

<!--- BEGIN HEALTH CHECK --->

<!DOCTYPE html>
<html lang="en" >
<cfoutput>

<head>
	<title>Toolbox: DB Health Check</title>

	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<style type="text/css">
		.error {
			color: red;
			font-weight: bold;
		}
		.success {
			color: darkgreen;
		}
	</style>
</head>

<body>

<cfinclude template="DBSetup.cfm" />

<p><a href="DBTools.cfm" >Back to DB tools</a></p>

<cfloop collection="#DBExpectedSetup#" item="CurrentTableName" >

	<cfset RedundantColumnError = false />

	<h2>TABLE CHECK: <u>#CurrentTableName#</u></h2>

	<!--- Table existence check --->
	<cftry>
		<cfdbinfo name="CurrentTableData" type="columns" table="#CurrentTableName#" />
		<p class="success" >Database has table by the name of <u>#CurrentTableName#</u></p>

	<cfcatch type="lucee.runtime.exp.ApplicationException" >

		<p class="error" >MISSING TABLE ERROR: Database has no table by the name of <u>#CurrentTableName#</u></p>
		<hr/>
		<cfcontinue/>
	</cfcatch>
	</cftry>

	<!--- Redundant column check --->
	<cfset CurrentCheckTableColumnList = structKeyList(DBExpectedSetup[ CurrentTableName ]) />

	<cfquery name="CurrentTableColumnList" dbtype="query" >
		SELECT COLUMN_NAME
		FROM CurrentTableData;
	</cfquery>

	<cfloop query="#CurrentTableColumnList#" >
		<cfif listFindNoCase(CurrentCheckTableColumnList, CurrentTableColumnList.COLUMN_NAME) IS 0 >
			<p><span class="error" >REDUNDANT COLUMN:</span> There's a column called <u>#CurrentTableColumnList.COLUMN_NAME#</u> in table <u>#CurrentTableName#</u> that is not in use.</p>
			<cfset RedundantColumnError = true />
		</cfif>
	</cfloop>

	<cfif RedundantColumnError IS false >
		<p class="success" >No redundant columns in table #CurrentTableName#</p>
	</cfif>

	<!--- CHECKING INDIVIDUAL COLUMNS --->
	<cfloop collection="#DBExpectedSetup[ CurrentTableName ]#" item="CurrentTableColumnName" >

		<cfset MissingColumnError = false />
		<cfset DataTypeError = false />
		<cfset PrimaryKeyError = false />
		<cfset ColumnSizeError = false />
		<cfset ForeignKeyError = false />
		<cfset ShouldBePrimaryKey = false />
		<cfset ShouldBeForeignKey = false />
		<cfset ShouldHaveSizeChecked = false />

		<cfset CurrentColumnCheckData = DBExpectedSetup[ CurrentTableName ][ CurrentTableColumnName ] />

		<cfquery name="CurrentColumnData" dbtype="query" >
			SELECT *
			FROM CurrentTableData
			WHERE COLUMN_NAME = '#CurrentTableColumnName#';
		</cfquery>

		<!--- MISSING COLUMN CHECK --->
		<cfif CurrentColumnData.RecordCount IS 0 >
			<p><span class="error" >MISSING COLUMN ERROR:</span> Column <u>#CurrentTableColumnName#</u> is missing from table <u>#CurrentTableName#</u></p>
			<cfset MissingColumnError = true />

			<cfcontinue/>
		</cfif>

		<!--- DATA TYPE CHECK --->
		<cfif CurrentColumnData.TYPE_NAME IS NOT CurrentColumnCheckData.type >
			<p>
				<span class="error" >WRONG DATA TYPE ERROR:</span> Column <u>#CurrentTableColumnName#</u> from table <u>#CurrentTableName#</u> has the wrong data type.<br/>
			 	We expected it to be <u>#CurrentColumnCheckData.type#</u> but it is <u>#CurrentColumnData.TYPE_NAME#</u>.
			</p>
			<cfset DataTypeError = true />
		</cfif>

		<!--- PRIMARY KEY CHECK --->
		<cfif CurrentColumnCheckData.primary_key IS true >
			<cfset ShouldBePrimaryKey = true />

			<cfif CurrentColumnData.IS_PRIMARYKEY IS false >
				<p><span class="error" >PRIMARY KEY ERROR:</span> Column <u>#CurrentTableColumnName#</u> from table <u>#CurrentTableName#</u> is not a primary key as expected.</p>
			</cfif>
			<cfset PrimaryKeyError = true />
		</cfif>

		<!--- SIZE CHECK --->
		<cfif  listFindNoCase("varchar,text", CurrentColumnCheckData.type) GT 0 >
			<cfset ShouldHaveSizeChecked = true />

			<cfif CurrentColumnData.COLUMN_SIZE IS NOT CurrentColumnCheckData.size >
				<p>
					<span class="error" >COLUMN SIZE ERROR:</span> Column <u>#CurrentTableColumnName#</u> from table <u>#CurrentTableName#</u> has the wrong size.<br/>
				 	We expected it to be <u>#CurrentColumnCheckData.size#</u> but it is <u>#CurrentColumnData.COLUMN_SIZE#</u>.
				 </p>
				 <cfset ColumnSizeError = true />
			</cfif>
		</cfif>

		<!--- FOREIGN KEY CHECK --->
		<cfif CurrentColumnCheckData.foreign_key IS true >
			<cfset ShouldBeForeignKey = true />

			<cfif CurrentColumnData.IS_FOREIGNKEY IS false >
				<span class="error" >FOREIGN KEY ERROR:</span> Column <u>#CurrentTableColumnName#</u> from table <u>#CurrentTableName#</u> is not a foreign key as expected.</span>
				<cfcontinue/>
			</cfif>

			<cfif CurrentColumnData.REFERENCED_PRIMARYKEY_TABLE[1] IS NOT CurrentColumnCheckData.references.table >
				<p>
					<span class="error" >FOREIGN KEY ERROR:</span> Column <u>#CurrentTableColumnName#</u> from table <u>#CurrentTableName#</u> does not reference the table expected.<br/>
					We expected it to reference <u>#CurrentColumnCheckData.references.table#</u> but it references <u>#CurrentColumnData.REFERENCED_PRIMARYKEY_TABLE[1]#</u> instead.
				</p>
				<cfset ForeignKeyError = true />
			</cfif>

			<cfif CurrentColumnData.REFERENCED_PRIMARYKEY[1] IS NOT CurrentColumnCheckData.references.key >
				<p>
					<span class="error" >FOREIGN KEY ERROR:</span> Column <u>#CurrentTableColumnName#</u> from table <u>#CurrentTableName#</u> does not reference the key expected.<br/>
					We expected it to reference <u>#CurrentColumnCheckData.references.key#</u> but it references <u>#CurrentColumnData.REFERENCED_PRIMARYKEY[1]#</u> instead.
				</p>
				<cfset ForeignKeyError = true />
			</cfif>
		</cfif>

		<cfif MissingColumnError IS false >

			<li><span class="success" >Column <u>#CurrentTableColumnName#</u> is not missing and:</span></li>

			<ul>
				<cfif DataTypeError IS false >
					<li><p class="success" >...its DATA TYPE is correct (#CurrentColumnCheckData.type#)</span></li>
				</cfif>

				<cfif PrimaryKeyError IS false AND ShouldBePrimaryKey IS true >
					<li><p class="success" >...it is the PRIMARY KEY as expected</span></li>
				</cfif>

				<cfif ColumnSizeError IS false AND ShouldHaveSizeChecked IS true >
					<li><p class="success" >...its SIZE is correct (#CurrentColumnCheckData.size#)</span></li>
				</cfif>

				<cfif ForeignKeyError IS false AND ShouldBeForeignKey IS true >
					<li><p class="success" >...it is a FOREIGN KEY and is referencing the correct table and column (#CurrentColumnCheckData.references.key# in #CurrentColumnCheckData.references.table#)</span></li>
				</cfif>
			</ul>

		</cfif>

	</cfloop>

<hr/>
</cfloop>

</body>

</cfoutput>
</html>