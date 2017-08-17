<cfprocessingdirective pageencoding="utf-8" />
<cfinclude template="checkauth.cfm" />

<cfinclude template="DBSetup.cfm" />

<!DOCTYPE html>
<html lang="en" >
<cfoutput>

<head>
	<title>Toolbox: DB Structure Chart</title>

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
	<p><a href="DBTools.cfm?token=#URL.token#" >Back to DB Tools</a></p>
	<h1>DB Chart of Expected Structure</h1>

	<cfloop collection="#DBExpectedSetup#" item="CurrentTableName" >

		<h1 class="table_headers" >#CurrentTableName#</h1>

		<table border="0" >
			<thead>
				<tr>
					<th>COLUMN NAME</th>
					<th>TYPE</th>
					<th>SIZE</th>
					<th>PRIMARY KEY</th>
					<th>FOREIGN KEY</th>
					<th>REFERENCES</th>
				</tr>
			</thead>

			<tbody>
				<cfloop collection="#DBExpectedSetup[ CurrentTableName ]#" item="CurrentTableColumnName" >

					<cfset CurrentColumnData = DBExpectedSetup[ CurrentTableName ][ CurrentTableColumnName ] />

					<tr>
						<td class="column_name" >#CurrentTableColumnName#</td>
						<td>#CurrentColumnData.type#</td>

						<cfif CurrentColumnData.size GT 0 >
							<td class="highlight_td_positive" >#CurrentColumnData.size#</td>
						<cfelse>
							<td class="highlight_td_negative" >N/A</td>
						</cfif>

						<cfif CurrentColumnData.primary_key IS true>
							<td class="highlight_td_positive" >
						<cfelse>
							<td class="highlight_td_negative" />
						</cfif>
							#uCase(toString(CurrentColumnData.primary_key))#
						</td>

						<cfif CurrentColumnData.foreign_key IS true>
							<td class="highlight_td_positive" >
						<cfelse>
							<td class="highlight_td_negative" >
						</cfif>
							#uCase(toString(CurrentColumnData.foreign_key))#
						</td>

						<cfif structIsEmpty(CurrentColumnData.references) IS false >
							<td class="highlight_td_positive" >#CurrentColumnData.references.key# IN #CurrentColumnData.references.table#</td>
						<cfelse>
							<td class="highlight_td_negative" >N/A</td>
						</cfif>
					</tr>

				</cfloop>
			</tbody>

		</table>
	</cfloop>

</body>

</cfoutput>
</html>