<cfprocessingdirective pageencoding="utf-8" />
<cfinclude template="checkauth.cfm" />

<!DOCTYPE html>
<html lang="en" >
<cfoutput>

<head>
	<title>Toolbox: List Users</title>

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
	
	<p><a href="UserTools.cfm?token=#URL.token#" >Back to User Tools</a></p>
	<h1>List of users</h1>

	<cfset UsersInterface = createObject("component", "Models.User") />
	<cfset AllUsers = UsersInterface.getData( Datasource=application.settings.datasource ) />
	<cfset TableColumnsList = "#UsersInterface.getTableKey()#,#UsersInterface.getTableColumns()#" />

	<table>
		<thead>
			<tr>
				<cfloop list=#TableColumnsList# index="CurrentColumnName" >
					<th>#CurrentColumnName#</th>
				</cfloop>
			</tr>
		</thead>

		<tbody>
			<cfloop query="AllUsers" >

				<tr>
					<cfloop list=#TableColumnsList# index="CurrentColumnName" >
						<cfif findNoCase("{ts", AllUsers[CurrentColumnName]) GT 0 >
							<td>#LSDateTimeFormat(AllUsers[CurrentColumnName], "dd-mm-yyyy HH:nn:ss")#</td>
						<cfelseif findNoCase("password", CurrentColumnName) GT 0 >
							<td>*****</td>
						<cfelse> 
							<td>#AllUsers[CurrentColumnName]#</td>
						</cfif>
					</cfloop>
				</tr>

			</cfloop>
		</tbody>
	</table>

</body>

</cfoutput>
</html>