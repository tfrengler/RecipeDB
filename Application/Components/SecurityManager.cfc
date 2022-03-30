<cfcomponent output="false" persistent="true" accessors="false" modifier="final" >

	<cfproperty name="SecretKey" type="numeric" getter="false" setter="false" />
	<cfproperty name="Encoding"  type="string"  getter="false" setter="false" />
	<cfproperty name="HashType"  type="string"  getter="false" setter="false" />

	<cffunction name="Init" returntype="SecurityManager" access="public" hint="" output="false" >
		<cfset variables.SecretKey = generateSecretKey("AES") />
		<cfset variables.Encoding = "UTF-8" />
		<cfset variables.HashType = "SHA-512" />
	</cffunction>

	<cffunction name="GetHashedString" returntype="string" access="public" hint="" output="false"  >
		<cfargument name="stringData" type="string" required="true" hint="" output="false" />

		<cfif len(trim(arguments.stringData)) EQ 0 >
			<cfthrow message="" detail="" />
		</cfif>

		<cfset var HashedString = hash(arguments.stringData, variables.HashType, variables.Encoding) />

		<cfreturn HashedString />
	</cffunction>

	<cffunction name="GetSaltedString" returntype="string" access="public" hint="" output="false"  >
		<cfreturn hash(generateSecretKey("AES"), variables.HashType, variables.Encoding) />
	</cffunction>

	<cffunction name="GenerateNonce" returntype="string" access="public" hint="" output="false"  >
		<cfreturn toBase64(generateSecretKey("AES", 128)) />
	</cffunction>

	<cffunction name="CreatePassword" returntype="string" access="public" hint="" output="false"  >

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

	<cffunction name="GenerateSessionToken" returntype="string" access="public" hint="" output="false"  >
		<cfargument name="cfSessionID" type="string" required="true" hint="" output="false"  />

		<cfif len(trim(arguments.cfSessionID)) EQ 0 >
			<cfthrow message="Bad arguments!" detail="Argument cfSessionID is empty!" />
		</cfif>

		<cfreturn hash((arguments.cfSessionid & variables.SecretKey), variables.HashType, variables.Encoding) />
	</cffunction>

	<cffunction name="GenerateAuthKey" returntype="string" access="public" hint="" output="false"  >
		<cfargument name="cfSessionID" type="string" required="true" hint="" output="false" />

		<cfif len(trim(arguments.cfSessionID)) EQ 0 >
			<cfthrow message="Bad arguments!" detail="Argument cfSessionID is empty!" />
		</cfif>

		<cfreturn hash(generateSecretKey("AES") & arguments.cfSessionID, variables.HashType, variables.Encoding) />
	</cffunction>

	<cffunction name="TryLogIn" returntype="numeric" access="public" hint="" output="false" >
		<cfargument name="username" type="string" required="true" hint="" output="false" />
		<cfargument name="password" type="string" required="true" hint="" output="false" />
		<cfargument name="session" type="struct" required="true" hint="" output="false" />

		<cfset var UserSearch = Models.User::GetBy(
			ColumnToSearchOn="UserName",
			SearchOperator="equal to",
			SearchData=arguments.username
		) />

		<cfif UserSearch.RecordCount IS 1 >
			<cfset var LoggedInUser = new Models.User(UserSearch[ Models.User::TableKey ]) />

		<cfelseif UserSearch.RecordCount IS 0 >
			<cfreturn 1 />
			<!--- User name does not exist/is incorrect --->

		<cfelseif UserSearch.RecordCount GT 1 >
			<cfreturn 2 />
			<!--- There's more than one record with this username --->
		</cfif>

		<cfif LoggedInUser.validatePassword( Password=arguments.password, SecurityManager=this ) IS false >
			<cfreturn 3 />
			<!--- Password is incorrect --->
		</cfif>

		<cfif LoggedInUser.getBlocked() IS 1 >
			<cfreturn 4 />
			<!--- User account is blocked --->
		</cfif>

		<!--- LOGIN/AUTHENTICATION PROCESS --->
		<cflogin applicationtoken="RecipeDB" idletimeout="3600" >

			<cfif LoggedInUser.getUserName() IS "tfrengler" >
				<cfloginuser name="#LoggedInUser.getUserName()#" password="#LoggedInUser.getPassword()#" roles="Admin" />
			<cfelse>
				<cfloginuser name="#LoggedInUser.getUserName()#" password="#LoggedInUser.getPassword()#" roles="User" />
			</cfif>

			<cfset LoggedInUser.updateLoginStats(
				UserAgentString=cgi.http_user_agent
			) />
			<cfset LoggedInUser.save() />

			<cfset arguments.session.authKey = GenerateAuthKey(arguments.session.sessionid) />
			<cfset arguments.session.currentUser = LoggedInUser />

			<cfreturn 0 />
		</cflogin>
	</cffunction>

	<cffunction name="IsValidSession" returntype="boolean" access="public" hint="" output="false" >
		<cfargument name="cookieScope" type="struct" required="true" hint="" output="false" />
		<cfargument name="sessionScope" type="struct" required="true" hint="" output="false" />
		<cfscript>

			if ( !HasValidSessionCookie(arguments.cookieScope) )
				return false;

			if (!structKeyExists( arguments.sessionScope, "SessionToken" ))
				return false;

			if (arguments.cookieScope[application.cookieName] != arguments.sessionScope.SessionToken)
				return false;

			return true;
		</cfscript>
	</cffunction>

	<cffunction name="HasValidSessionCookie" returntype="boolean" access="public" hint="" output="false" >
		<cfargument name="cookieScope" type="struct" required="true" hint="" output="false" />

		<cfreturn structKeyExists( arguments.cookieScope, application.cookieName ) />
	</cffunction>

	<cffunction name="NewSession" returntype="void" access="public" hint="" output="false" >
		<cfargument name="sessionScope" type="struct" required="true" hint="" output="false" />
		<cfscript>

			var NewToken = GenerateSessionToken(arguments.sessionScope.sessionid);
			arguments.sessionScope.SessionToken = NewToken;
			SetSessionCookie(NewToken, false);

		</cfscript>
	</cffunction>

	<cffunction name="SetSessionCookie" returntype="void" access="public" hint="" output="false" >
		<cfargument name="sessionToken" type="string" required="true" hint="" output="false" />
		<cfargument name="expired" type="boolean" required="false" default="false" hint="" output="false" />
		<cfscript>

			if (arguments.sessionToken.len() == 0)
			{
				throw(message="Empty arguments!", detail="Argument sessionToken is empty!");
			}

			cfcookie(
				preserveCase="true",
				name="#application.cookieName#",
				value="#arguments.sessionToken#",
				path="/",
				domain="#listFirst(cgi.HTTP_HOST, ':')#",
				expires="#arguments.expired ? now() : dateAdd("n", 60, now())#",
				httpOnly="true",
				secure="true",
				samesite="strict"
			);

		</cfscript>
	</cffunction>
</cfcomponent>