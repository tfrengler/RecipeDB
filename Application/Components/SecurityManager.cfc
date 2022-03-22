<cfcomponent output="false" >

	<cfset SecretKey = "27A19594-F01F-AF65-F844BA5EB80A5C06" />

	<cffunction name="getHashedString" returntype="string" access="public" hint="" output="false"  >
		<cfargument name="StringData" type="string" required="true" hint="" output="false"  />

		<cfset var HashedString = hash(arguments.StringData, "SHA-512", "utf-8") />

		<cfreturn HashedString />
	</cffunction>

	<cffunction name="getSaltedString" returntype="string" access="public" hint="" output="false"  >
		<cfreturn Hash(GenerateSecretKey("AES"), "SHA-512") />
	</cffunction>

	<cffunction name="createPassword" returntype="string" access="public" hint="" output="false"  >

		<cfset var ValidLowerCaseAlpha = "abcdefghijklmnopqrstuvwxyz" />
		<cfset var ValidUpperCaseAlpha = UCase( ValidLowerCaseAlpha ) />
		<cfset var ValidNumbers = "0123456789" />
		<cfset var ValidSpecialChars = "~!@##$%^&*" />

		<cfset var AllValidChars = (ValidLowerCaseAlpha & ValidUpperCaseAlpha & ValidNumbers & ValidSpecialChars) />
		<cfset var Password = [] />
		<cfset var RandomPasswordValue = "" />

		<cfset var Index = 0 />
		<cfloop from="1" to="8" index="Index" >
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

	<cffunction name="generateAuthKey" returntype="string" access="public" hint="" output="false"  >
		<cfset var AuthKey = "" />

		<cfif structKeyExists(session, "sessionid") >
			<cfset AuthKey = (session.sessionid & variables.SecretKey) />
		<cfelse>
			<cfthrow message="Error generating authkey" detail="The sessionid does not appear to exist in the session scope!" />
		</cfif>

		<cfreturn hash(AuthKey, "SHA-512") />
	</cffunction>

	<!--- <cffunction name="removeHTMLTags" returntype="string" access="private" hint="Removes HTML from a string. Will remove entire tag and its attributes (http://cflib.org/udf/stripHTML)" >
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

	<cffunction name="removeIllegalHTML" returntype="string" output="false">
		<cfargument name="htmlString" required="true" type="string">
		<cfargument name="tagsAllowed" required="false" type="string" default="a,p,h1,h2,h3,h4,h5,h6,h7,h8,h9,b,strong,i,ol,ul,li,br,img,span">

		<cfset var cleanedString = arguments.htmlString />
		<cfset var tagFound = "" />
		<cfset var stringStartPos = 0 />
		<cfset var cleanedStringLeft = "" />
		<cfset var cleanedStringRight = "" />

		<!--- LOOP OVER TEXT AND FIND ALL TAGS --->
		<cfloop condition="stringStartPos LT len(cleanedString)">
		<!--- FIND HTML TAGS --->
			<cfset tagFound = refindnocase("</{0,1}(.[^>]*?)>",cleanedString,stringStartPos,"true")>

			<!--- TAGS FOUND? --->
			<cfif tagFound.pos[1] IS 0>
				<!--- NO TAGS FOUND -> EXIT LOOP --->
				<cfset stringStartPos = len(arguments.htmlString) + 5>
			<cfelse>
				<!--- TAGS FOUND --->
				<!--- CHECK IF TAGS MUST BE CLEARED --->
				<cfif NOT listFindNoCase(arguments.tagsAllowed,listFirst(mid(cleanedString,tagFound.pos[2],tagFound.len[2]), '<>/ '))>
					<!--- CLEAR TAG --->
					<!--- CREATE NEW RETURN STRING --->
					<cfif tagFound.pos[1] IS NOT 1 />
						<cfset cleanedStringLeft = left(cleanedString,tagFound.pos[1]-1) />
					<cfelse>
						<cfset cleanedStringLeft = "" />
					</cfif>

					<cfif len(cleanedString) - (tagFound.pos[1]+tagFound.len[1])+1 GT 0 />
						<cfset cleanedStringRight = right(cleanedString, len(cleanedString) - (tagFound.pos[1]+tagFound.len[1])+1) />
					<cfelse>
						<cfset cleanedStringRight = "" />
					</cfif>

					<cfset cleanedString = cleanedStringLeft & cleanedStringRight>
				<cfelse>
					<!--- TAG ALLOWED --->
					<cfset stringStartPos = tagFound.pos[1] + tagFound.len[1]>
				</cfif>
			</cfif>
		</cfloop>

		<cfreturn trim(cleanedString)>
	</cffunction>

	<cffunction name="removeWordCode" returntype="string" output="false" >
		<cfargument name="string" type="string" required="true" />
		<cfargument name="hardClean" type="boolean" required="false" default="true" />

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

		<cfif arguments.hardClean >
			<cfset CleanedText = REReplace(CleanedText, "</?(span|div|o:p|p)>", "", "ALL") />
		<cfelse>
			<cfset CleanedText = REReplace(CleanedText, "</?(o:p)>", "", "ALL") />
		</cfif>

		<cfreturn CleanedText />
	</cffunction>

	<cffunction name="removeExtendedASCIIChars" access="public" returntype="string" output="no" hint="This scans through a string, finds any characters that have a higher ASCII numeric value greater than 127 and automatically convert them to a hexadecimal numeric character">
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
    </cffunction> --->

</cfcomponent>