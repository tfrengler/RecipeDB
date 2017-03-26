<cfcomponent output="false" >
<cfprocessingdirective pageEncoding="utf-8"  />

	<cfset RecipePicturePath = "#expandPath("/Mappings")#/Pictures/Recipes" />
	<cfset StandardPicturePath = "#expandPath("/Mappings")#/Pictures/Standard" />

	<cffunction name="upload" access="public" output="false" hint="" >
		<cfreturn true />
	</cffunction>

	<cffunction name="download" access="public" output="false" hint="" >
		<cfreturn true />
	</cffunction>

	<cffunction name="getRecipePath" access="public" output="false" hint="" >
		<cfreturn true />
	</cffunction>

	<cffunction name="getStandardPath" access="public" output="false" hint="" >
		<cfreturn true />
	</cffunction>

</cfcomponent>