<cfcomponent output="false" >
<cfprocessingdirective pageEncoding="utf-8"  />

	<cffunction name="getHashedString" returntype="string" access="public" hint="" >
		<cfargument name="StringData" type="string" required="true" hint="" />

		<cfset var HashedString = hash(arguments.StringData, "SHA-256", "utf-8") />

		<cfreturn HashedString />
	</cffunction>

	<cffunction name="createPassword" returntype="string" access="public" hint="" >

		<cfset var ValidLowerCaseAlpha = "abcdefghijklmnopqrstuvwxyz" />
		<cfset var ValidUpperCaseAlpha = UCase( ValidLowerCaseAlpha ) />
		<cfset var ValidNumbers = "0123456789" />
		<cfset var ValidSpecialChars = "~!@##$%^&*" />

		<cfset var AllValidChars = (ValidLowerCaseAlpha & ValidUpperCaseAlpha & ValidNumbers & ValidSpecialChars) />
		<cfset var Password = arrayNew(1) />
		<cfset var RandomPasswordValue = "" />

		<cfloop from="1" to="8" index="index" >
			<cfset RandomPasswordValue = mid(
				AllValidChars,
				randRange(1, len(AllValidChars)),
				1
			) />

			<cfset arrayAppend(Password, RandomPasswordValue) />
		</cfloop>

		<cfset Password = arrayToList(Password, "") />
		
		<cfreturn Password />
	</cffunction>


	<cffunction name="removeTagsFromString" returntype="string" access="private" hint="Removes HTML from a string. Will remove entire tag and its attributes (http://cflib.org/udf/stripHTML)" >
		<cfargument name="StringData" type="string" required="true" />
		<cfargument name="SpecialTagsOnly" type="boolean" required="false" default="false" />
		
		<cfset var sSpecialTags = "style,script,noscript" />
		<cfset var sCurrentTag = "" />
		<cfset var ReturnData = arguments.StringData />
		
		<cfloop list="#sSpecialTags#" index="sCurrentTag" >
			<cfset ReturnData = reReplaceNoCase(ReturnData, "<\s*(#sCurrentTag#)[^>]*?>(.*?)</\1>","","ALL") />
		</cfloop>

		<cfif arguments.SpecialTagsOnly >
			<cfset ReturnData = reReplaceNoCase(ReturnData, "<.*?>","","ALL") />
			<!--- Get partial html in front --->
			<cfset ReturnData = reReplaceNoCase(ReturnData, "^.*?>","") />		
			<!--- Get partial html at end --->
			<cfset ReturnData = reReplaceNoCase(ReturnData, "<.*$","") />
		</cfif>

		<cfreturn trim(ReturnData) />
	</cffunction>

</cfcomponent>