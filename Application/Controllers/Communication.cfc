<cfcomponent output="false" >
<cfprocessingdirective pageEncoding="utf8" />

 	<cffunction name="getPatchNotesView" access="public" returntype="struct" output="false" hint="" >
 
 		<cfset var ReturnData = {} />
 		<cfset ReturnData.patchNoteCollection = arrayNew(1) />
 
 		<cfset var PatchNotesList = queryNew("") />
 		<cfset var PatchNoteContents = "" />
 
 		<cfdirectory directory="#expandPath("/PatchNotes")#" action="list" filter="*.html" name="PatchNotesList" />
 
 		<cfloop query="#PatchNotesList#" >
 
 			<cfset PatchNoteContents = "" />
 
 			<cffile 
 				action="read" 
 				file="#PatchNotesList.directory#\#PatchNotesList.name#"
 				variable="PatchNoteContents" 
 				charset="utf8"
 			/>
 
 			<cfset arrayAppend(ReturnData.patchNoteCollection, PatchNoteContents) />
 
 		</cfloop>
 		
 		<cfreturn ReturnData />
	</cffunction>
 
 	<cffunction name="getRoadmapView" access="public" returntype="struct" output="false" hint="" >
 
 		<cfset var ReturnData.roadMap = "" />
 
 		<cffile 
 			action="read" 
 			file="#expandPath("/Roadmap")#/Roadmap.html" 
 			variable="ReturnData.roadMap" 
 			charset="utf8"
 		/>
 		
 		<cfreturn ReturnData />
 	</cffunction>
 
 </cfcomponent> 