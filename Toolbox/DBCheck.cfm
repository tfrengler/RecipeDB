<cfoutput>

<cfparam name="URL.token" default="0" />
<cfif URL.token IS NOT 86954494 >
	<p>Look at you, hacker: a pathetic creature of meat and bone, panting and sweating as you run through my corridors. How can you challenge a perfect, immortal machine?</p>
	<cfabort/>
</cfif>

<!--- BEGIN HEALTH CHECK --->

<cfloop collection="#DBInfo#" item="CurrentTableName" >

	<h2>TABLE CHECK: <u>#CurrentTableName#</u></h2>

	<cftry>
		<cfdbinfo name="CurrentTableData" type="columns" table="#CurrentTableName#" datasource="#application.Settings.Datasource#" />

	<cfcatch type="lucee.runtime.exp.ApplicationException" >

		<p><b>MISSING TABLE ERROR:</b> Database has no table by the name of <b>#CurrentTableName#</b></p>
		<hr/>
		<cfcontinue/>
	</cfcatch>
	</cftry>

	<cfset CurrentCheckTableColumnList = structKeyList(DBInfo[ CurrentTableName ]) />

	<cfquery name="CurrentTableColumnList" dbtype="query" >
		SELECT COLUMN_NAME
		FROM CurrentTableData;
	</cfquery>

	<cfloop query="#CurrentTableColumnList#" >	
		<cfif listFindNoCase(CurrentCheckTableColumnList, CurrentTableColumnList.COLUMN_NAME) IS 0 >
			<p><span class="error" >REDUNDANT COLUMN:</span> There's a column called <b>#CurrentTableColumnList.COLUMN_NAME#</b> in table <b>#CurrentTableName#</b> that is not in use.</p>
		</cfif>
	</cfloop>

	<!--- CHECKING INDIVIDUAL COLUMNS --->
	<cfloop collection="#DBInfo[ CurrentTableName ]#" item="CurrentTableColumnName" >

		<cfset CurrentColumnCheckData = DBInfo[ CurrentTableName ][ CurrentTableColumnName ] />

		<cfquery name="CurrentColumnData" dbtype="query" >
			SELECT *
			FROM CurrentTableData
			WHERE COLUMN_NAME = '#CurrentTableColumnName#';
		</cfquery>

		<!--- MISSING COLUMN CHECK --->
		<cfif CurrentColumnData.RecordCount IS 0 >
			<p><span class="error" >MISSING COLUMN ERROR:</span> Column <b>#CurrentTableColumnName#</b> is missing from table <b>#CurrentTableName#</b></p>
			<cfcontinue/>
		</cfif>

		<!--- DATA TYPE CHECK --->
		<cfif CurrentColumnData.TYPE_NAME IS NOT CurrentColumnCheckData.type >
			<p>
				<span class="error" >WRONG DATA TYPE ERROR:</span> Column <b>#CurrentTableColumnName#</b> from table <b>#CurrentTableName#</b> has the wrong data type.<br/>
			 	We expected it to be <b>#CurrentColumnCheckData.type#</b> but it is <b>#CurrentColumnData.TYPE_NAME#</b>.
			 </p>
		</cfif>

		<!--- DATA TYPE CHECK --->
		<cfif CurrentColumnCheckData.primary_key IS true >
			<cfif CurrentColumnData.IS_PRIMARYKEY IS false >
				<p><span class="error" >PRIMARY KEY ERROR:</span> Column <b>#CurrentTableColumnName#</b> from table <b>#CurrentTableName#</b> is not a primary key as expected.</p>
			</cfif>
		</cfif>

		<!--- SIZE CHECK --->
		<cfif  listFindNoCase("varchar,text", CurrentColumnCheckData.type) GT 0 >
			<cfif CurrentColumnData.COLUMN_SIZE IS NOT CurrentColumnCheckData.size >
				<p>
					<span class="error" >COLUMN SIZE ERROR:</span> Column <b>#CurrentTableColumnName#</b> from table <b>#CurrentTableName#</b> has the wrong size.<br/>
				 	We expected it to be <b>#CurrentColumnCheckData.size#</b> but it is <b>#CurrentColumnData.COLUMN_SIZE#</b>.
				 </p>
			</cfif>
		</cfif>

		<!--- FOREIGN KEY CHECK --->
		<cfif CurrentColumnCheckData.foreign_key IS true >
			<cfif CurrentColumnData.IS_FOREIGNKEY IS false >
				<span class="error" >FOREIGN KEY ERROR:</span> Column <b>#CurrentTableColumnName#</b> from table <b>#CurrentTableName#</b> is not a foreign key as expected.</p>
				<cfcontinue/>
			</cfif>

			<cfif CurrentColumnData.REFERENCED_PRIMARYKEY_TABLE[1] IS NOT CurrentColumnCheckData.references.table >
				<p>
					<span class="error" >FOREIGN KEY ERROR:</span> Column <b>#CurrentTableColumnName#</b> from table <b>#CurrentTableName#</b> does not reference the table expected.<br/>
					We expected it to reference <b>#CurrentColumnCheckData.references.table#</b> but it references <b>#CurrentColumnData.REFERENCED_PRIMARYKEY_TABLE[1]#</b> instead.
				</p>
			</cfif>

			<cfif CurrentColumnData.REFERENCED_PRIMARYKEY[1] IS NOT CurrentColumnCheckData.references.key >
				<p>
					<span class="error" >FOREIGN KEY ERROR:</span> Column <b>#CurrentTableColumnName#</b> from table <b>#CurrentTableName#</b> does not reference the key expected.<br/>
					We expected it to reference <b>#CurrentColumnCheckData.references.key#</b> but it references <b>#CurrentColumnData.REFERENCED_PRIMARYKEY[1]#</b> instead.
				</p>
			</cfif>
		</cfif>
	</cfloop>

<hr/>
</cfloop>
</cfoutput>