<cfinclude template="CheckAuth.cfm" />

<!DOCTYPE html>
<html lang="en" >
<cfoutput>

<head>
	<title>Toolbox: DB Inspection</title>

	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<style type="text/css">
		table {
			background-color: ##639c9c;
			font-size: 1.4em;
		}

		table, td {
			border-style: solid;
			border-width: 1px;
		}

		td, th {
			padding-left: 0.5em; 
			padding-right: 0.5em;
		}

		.table_headers, .column_name, th {
			background-color: ##3d5c5c;
			color: white;
		}

		td {

		}

		tbody tr:nth-child(odd) {
			background-color: lightgrey;
		}

		tbody tr:nth-child(even) {
			background-color: ##e0ebeb;
		}

		.highlight_td_positive {
			color: green;
			font-weight: bold;
		}

		.highlight_td_negative {
			color: darkred;
		}
	</style>
</head>

<body>
	<p><a href="DBTools.cfm" >Back to DB Tools</a></p>
	<h1>Overview of current db structure</h1>

	<cfdbinfo type="Tables" name="DatabaseTableInfo" />

	<cfquery name="DatabaseTables" dbtype="query" >
		SELECT table_name
		FROM DatabaseTableInfo
		WHERE table_type = 'TABLE';
	</cfquery>

	<cfif DatabaseTables.RecordCount GT 0 >

		<cfloop query="DatabaseTables" >

			<cfdbinfo type="Columns" name="DatabaseTableColumnInfo" table="#DatabaseTables.table_name#" />

			<!--- <cfdump var="#DatabaseTableColumnInfo#" abort="true" /> --->

			<h1 class="table_headers" >#uCase(DatabaseTables.table_name)#</h1>

			<table>
				<thead>
					<tr>
						<th>COLUMN NAME</th>
						<th>DATA TYPE</th>
						<th>COLUMN SIZE</th>
						<th>DECIMAL LENGTH</th>
						<th>NULLABLE</th>
						<th>DEFAULT VALUE</th>
						<th>AUTO INCREMENT</th>
						<th>PRIMARY KEY</th>
						<th>FOREIGN KEY</th>
						<th>REFERENCED KEY</th>
						<th>REFERENCED TABLE</th>
					</tr>
				</thead>

				<tbody>
					<cfloop query="DatabaseTableColumnInfo" >

						<tr>
							<td class="column_name" >#uCase(DatabaseTableColumnInfo.COLUMN_NAME)#</td>

							<td>#DatabaseTableColumnInfo.TYPE_NAME#</td>

							<cfif DatabaseTableColumnInfo.COLUMN_SIZE GT 0 >
								<td class="highlight_td_positive" >#DatabaseTableColumnInfo.COLUMN_SIZE#</td>
							<cfelse>
								<td class="highlight_td_negative" >N/A</td>
							</cfif>

							<cfif DatabaseTableColumnInfo.DECIMAL_DIGITS GT 0 >
								<td class="highlight_td_positive" >#DatabaseTableColumnInfo.DECIMAL_DIGITS#</td>
							<cfelse>
								<td class="highlight_td_negative" >N/A</td>
							</cfif>

							<cfif DatabaseTableColumnInfo.IS_NULLABLE IS 1 >
								<td class="highlight_td_positive" >YES</td>
							<cfelse>
								<td class="highlight_td_negative" >NO</td>
							</cfif>

							<cfif len(DatabaseTableColumnInfo.COLUMN_DEFAULT_VALUE) GT 0 >
								<td class="highlight_td_positive" >#DatabaseTableColumnInfo.COLUMN_DEFAULT_VALUE#</td>
							<cfelse>
								<td class="highlight_td_negative" >N/A</td>
							</cfif>

							<cfif DatabaseTableColumnInfo.IS_AUTOINCREMENT IS 1 >
								<td class="highlight_td_positive" >
							<cfelse>
								<td class="highlight_td_negative" >
							</cfif>
								#DatabaseTableColumnInfo.IS_AUTOINCREMENT#
							</td>

							<cfif DatabaseTableColumnInfo.IS_PRIMARYKEY EQ true >
								<td class="highlight_td_positive" >
							<cfelse>
								<td class="highlight_td_negative" />
							</cfif>
								#DatabaseTableColumnInfo.IS_PRIMARYKEY#
							</td>

							<cfif DatabaseTableColumnInfo.IS_FOREIGNKEY EQ true >
								<td class="highlight_td_positive" >
							<cfelse>
								<td class="highlight_td_negative" />
							</cfif>
								#DatabaseTableColumnInfo.IS_FOREIGNKEY#
							</td>

							<cfif isValid("Array", DatabaseTableColumnInfo.REFERENCED_PRIMARYKEY) AND arrayLen(DatabaseTableColumnInfo.REFERENCED_PRIMARYKEY) GT 0 >
								<td class="highlight_td_positive" >#DatabaseTableColumnInfo.REFERENCED_PRIMARYKEY[1]#</td>
							<cfelse>
								<td class="highlight_td_negative" >N/A</td>
							</cfif>

							<cfif isValid("Array", DatabaseTableColumnInfo.REFERENCED_PRIMARYKEY_TABLE) AND arrayLen(DatabaseTableColumnInfo.REFERENCED_PRIMARYKEY_TABLE) GT 0 >
								<td class="highlight_td_positive" >#DatabaseTableColumnInfo.REFERENCED_PRIMARYKEY_TABLE[1]#</td>
							<cfelse>
								<td class="highlight_td_negative" >N/A</td>
							</cfif>
						</tr>

					</cfloop>
				</tbody>
			</table>

		</cfloop>

	</cfif>

</body>

</cfoutput>
</html>