<cfcomponent output="false" >
<cfprocessingdirective pageEncoding="utf8" />

	<cffunction name="main" access="public" returntype="struct" output="false" hint="" >

		<cfset var returnData = {
			statuscode: 0,
			data: structNew()
		} />

		<cffile
			action="read" 
			file="#application.settings.files.roadmap#/Roadmap.html" 
			variable="returnData.data.roadMap" 
			charset="utf8"
		/>
		
		<cfreturn returnData />
	</cffunction>

</cfcomponent> 