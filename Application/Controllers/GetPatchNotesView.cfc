<cfcomponent output="false" >
<cfprocessingdirective pageEncoding="utf8" />

	<cffunction name="main" access="public" returntype="struct" output="false" hint="" >

		<cfset var returnData = {
			statuscode: 0,
			data: structNew()
		} />

		<cfset var returnData.data.patchNoteCollection = arrayNew(1) />
		<cfset var patchNotesList = queryNew("") />
		<cfset var patchNoteContents = "" />

		<cfdirectory directory=#application.settings.files.patchnotes# action="list" filter="*.html" name="patchNotesList" sort="name DESC" />

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
</cfcomponent>