<cfcomponent output="false" >
<cfprocessingdirective pageEncoding="utf-8"  />

	<cfset SecretKey = "27A19594-F01F-AF65-F844BA5EB80A5C06" />

	<cffunction name="getHashedString" returntype="string" access="public" hint="" >
		<cfargument name="StringData" type="string" required="true" hint="" />

		<cfset var HashedString = hash(arguments.StringData, "SHA-512", "utf-8") />

		<cfreturn HashedString />
	</cffunction>

	<cffunction name="getSaltedString" returntype="string" access="public" hint="" >
		<cfreturn Hash(GenerateSecretKey("AES"), "SHA-512") /> 
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

	<cffunction name="generateAuthKey" returntype="string" access="public" hint="" >
		<cfset var AuthKey = "" /> 

		<cfif structKeyExists(session, "sessionid") >
			<cfset AuthKey = (session.sessionid & variables.SecretKey) />
		<cfelse>
			<cfthrow message="Error generating authkey" detail="The sessionid does not appear to exist in the session scope!" />
		</cfif>

		<cfreturn hash(AuthKey, "SHA-512") />
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

	<cffunction name="cleanWordMess" output="no" returntype="string">
		<cfargument name="string" type="string" required="true" />

		<!--- if nothing passed , return empty string --->
		<cfif len(trim(arguments.string) IS 0 )>
			<cfreturn "" />
		</cfif>

		<!--- create a tmporary variable to cold the passed text --->
		<cfset var CleanedText = arguments.inString />
		<!--- remove the HTML comments --->
		<cfset CleanedText = REReplace(CleanedText, "<!--.*-->", "", "ALL") />
		<!--- remove most of the unwanted HTML attributes with their values --->
		<cfset CleanedText = REReplace(CleanedText, "[ ]+(style|align|valign|dir|class|id|lang|width|height|nowrap)=""[^""]*""", "", "ALL") />
		<!--- clean extra spaces & tabs --->
		<cfset CleanedText = REReplace(CleanedText, "\s{2,}", " ", "ALL") />
		<!--- remove extra spaces between tags --->
		<cfset CleanedText = REReplace(CleanedText, ">\s{1,}<", "><", "ALL") />
		<!--- remove any &nbsp; spaces between tags --->
		<cfset CleanedText = REReplace(CleanedText, ">&nbsp;<", "><", "ALL") />
		<!--- remove empty <b> empty tags --->
		<cfset CleanedText = REReplace(CleanedText, "<b></b>", "", "ALL") />
		<!--- remove empty <p> empty tags --->
		<cfset CleanedText = REReplace(CleanedText, "<p></p>", "", "ALL") />
		<!--- Remove all unwanted tags opening and closing --->
		<cfset CleanedText = REReplace(CleanedText, "</?(span|div|o:p|p)>", "", "ALL") />
		<!--- remove and repetition of &nbsp; and make it one only --->
		<cfset CleanedText = REReplace(CleanedText, "(&nbsp;){2,}", "&nbsp;", "ALL") />

		<cfreturn local.text />
	</cffunction>

	<cffunction name="cleanExtendedASCIIChars" access="public" returntype="string" output="no" hint="This scans through a string, finds any characters that have a higher ASCII numeric value greater than 127 and automatically convert them to a hexadecimal numeric character">
        <cfargument name="text" type="string" required="true" />

        <!--- if nothing passed , return empty string --->
		<cfif len(trim(arguments.string) IS 0 )>
			<cfreturn "" />
		</cfif>

        <cfscript>
            var i = 0;
            var tmp = '';

            while(ReFind('[^\x00-\x7F]',text,i,false))
            {
                i = ReFind('[^\x00-\x7F]',text,i,false); // discover high chr and save its numeric string position.
                tmp = '&##x#FormatBaseN(Asc(Mid(text,i,1)),16)#;'; // obtain the high chr and convert it to a hex numeric chr.
                text = Insert(tmp,text,i); // insert the new hex numeric chr into the string.
                text = RemoveChars(text,i,1); // delete the redundant high chr from string.
                i = i+Len(tmp); // adjust the loop scan for the new chr placement, then continue the loop.
            }
            return text;
        </cfscript>

    </cffunction>

</cfcomponent>