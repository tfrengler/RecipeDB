<cfcomponent output="false" >
<cfprocessingdirective pageEncoding="utf8" />

	<cffunction name="getPatchNotesView" access="public" returntype="struct" output="false" hint="" >

		<cfset var returnData = {
			statuscode: 0,
			data: structNew()
		} />

		<cfset var returnData.data.patchNoteCollection = arrayNew(1) />
		<cfset var patchNotesList = queryNew("") />
		<cfset var patchNoteContents = "" />

		<cfdirectory directory="#expandPath("/PatchNotes")#" action="list" filter="*.html" name="patchNotesList" sort="name DESC" />

		<cfloop query="#patchNotesList#" >

			<cfset patchNoteContents = "" />

			<cffile 
				action="read" 
				file="#patchNotesList.directory#\#patchNotesList.name#"
				variable="PatchNoteContents" 
				charset="utf8"
			/>

			<cfset arrayAppend(returnData.data.patchNoteCollection, patchNoteContents) />

		</cfloop>
		
		<cfreturn returnData />
	</cffunction>

	<cffunction name="getRoadmapView" access="public" returntype="struct" output="false" hint="" >

		<cfset var returnData = {
			statuscode: 0,
			data: structNew()
		} />

		<cffile
			action="read" 
			file="#expandPath("/Roadmap")#/Roadmap.html" 
			variable="returnData.data.roadMap" 
			charset="utf8"
		/>
		
		<cfreturn returnData />
	</cffunction>

</cfcomponent> 