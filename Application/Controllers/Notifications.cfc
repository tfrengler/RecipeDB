<cfcomponent output="false" >
<cfprocessingdirective pageEncoding="utf-8" />

	<cffunction name="getStatisticsView" access="public" returntype="struct" returnformat="JSON" output="false" hint="" >

		<cfset var ReturnData = {
			status: "",
			message: "",
			data: ""
		} />

		<cfset var ViewArguments = structNew() />
		
		<!--- NOTE TO SELF: Use forward slashes for cfmodule paths that use mappings, derp --->
		<cfsavecontent variable="ReturnData.data" >
			<cfmodule template="/Views/Statistics.cfm" attributecollection="#ViewArguments#" >
		</cfsavecontent>

		<cfset ReturnData.status = "OK" />
		<cfreturn ReturnData />
	</cffunction>

	<cffunction name="getPatchNotesView" access="public" returntype="struct" returnformat="JSON" output="false" hint="" >

		<cfset var ReturnData = {
			status: "",
			message: "",
			data: ""
		} />

		<cfset var PatchNotesList = queryNew("") />
		<cfset var PatchNoteContents = "" />
		<cfset var ViewArguments.patchNoteCollection = arrayNew(1) />

		<cfdirectory directory="#expandPath("/PatchNotes")#" action="list" filter="*.html" name="PatchNotesList" />

		<cfloop query="#PatchNotesList#" >

			<cfset PatchNoteContents = "" />

			<cffile 
				action="read" 
				file="#PatchNotesList.directory#\#PatchNotesList.name#"
				variable="PatchNoteContents" 
				charset="utf-8"
			/>

			<cfset arrayAppend(ViewArguments.patchNoteCollection, PatchNoteContents) />

		</cfloop>
		
		<!--- NOTE TO SELF: Use forward slashes for cfmodule paths that use mappings, derp --->
		<cfsavecontent variable="ReturnData.data" >
			<cfmodule template="/Views/PatchNotes.cfm" attributecollection="#ViewArguments#" >
		</cfsavecontent>

		<cfset ReturnData.status = "OK" />
		<cfreturn ReturnData />
	</cffunction>

	<cffunction name="getRoadmapView" access="public" returntype="struct" returnformat="JSON" output="false" hint="" >
		<cfargument name="pageContext" type="struct" required="true" />

		<cfset var ReturnData = {
			status: "",
			message: "",
			data: ""
		} />

		<cfset var ViewArguments = {roadMap: ""} />

		<cffile 
			action="read" 
			file="#expandPath("/Roadmap")#/Roadmap.html" 
			variable="ViewArguments.roadMap" 
			charset="utf-8"
		/>
		
		<!--- NOTE TO SELF: Use forward slashes for cfmodule paths that use mappings, derp --->
		<cfsavecontent variable="ReturnData.data" >
			<cfmodule template="/Views/Roadmap.cfm" attributecollection="#ViewArguments#" >
		</cfsavecontent>

		<cfset ReturnData.status = "OK" />
		<cfreturn ReturnData />
	</cffunction>

</cfcomponent>