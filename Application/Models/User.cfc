<cfcomponent output="false" extends="Model" >
<cfprocessingdirective pageEncoding="utf-8" />

	<cfset UserID = 0 />
	<cfset DateCreated = createDate(1666, 6, 6) />
	<cfset DateTimePreviousLogin = createDateTime(1666, 6, 6, 6, 6, 6) />
	<cfset DateTimeLastLogin = createDateTime(1666, 6, 6, 6, 6, 6) />
	<cfset Password = "" />
	<cfset PasswordSalt = "" />
	<cfset TempPassword = "" />
	<cfset UserName = "" />
	<cfset DisplayName = "" />
	<cfset TimesLoggedIn = 0 />
	<cfset BrowserLastUsed = "" />
	<cfset Blocked = true />
	<cfset AuthKey = "" />

	<cfset TableName = "Users" />

	<!--- Getters --->

	<cffunction name="getID" access="public" returntype="numeric" output="false" hint="" >
		<cfreturn variables.UserID />
	</cffunction>

	<cffunction name="getDateTimePreviousLogin" access="public" returntype="date" output="false" hint="" >
		<cfreturn variables.DateTimePreviousLogin />
	</cffunction>

	<cffunction name="getDateCreated" access="public" returntype="date" output="false" hint="" >
		<cfreturn variables.DateCreated />
	</cffunction>

	<cffunction name="getDateTimeLastLogin" access="public" returntype="date" output="false" hint="" >
		<cfreturn variables.DateTimeLastLogin />
	</cffunction>

	<cffunction name="getPassword" access="public" returntype="string" output="false" hint="" >
		<cfreturn variables.Password />
	</cffunction>

	<cffunction name="getPasswordSalt" access="public" returntype="string" output="false" hint="" >
		<cfreturn variables.PasswordSalt />
	</cffunction>

	<cffunction name="getTempPassword" access="public" returntype="string" output="false" hint="" >
		<cfreturn variables.TempPassword />
	</cffunction>

	<cffunction name="getUserName" access="public" returntype="string" output="false" hint="" >
		<cfreturn variables.UserName />
	</cffunction>

	<cffunction name="getDisplayName" access="public" returntype="string" output="false" hint="" >
		<cfreturn variables.DisplayName />
	</cffunction>

	<cffunction name="getTimesLoggedIn" access="public" returntype="numeric" output="false" hint="" >
		<cfreturn variables.TimesLoggedIn />
	</cffunction>

	<cffunction name="getBrowserLastUsed" access="public" returntype="string" output="false" hint="" >
		<cfreturn variables.BrowserLastUsed />
	</cffunction>

	<cffunction name="getBlocked" access="public" returntype="boolean" output="false" hint="" >
		<cfreturn variables.Blocked />
	</cffunction>

	<cffunction name="getAuthKey" access="public" returntype="string" output="false" hint="" >
		<cfreturn variables.AuthKey />
	</cffunction>

	<!--- Setters --->

	<cffunction name="setID" access="private" output="false" hint="" >
		<cfargument name="Value" type="numeric" required="true" hint="" />

		<cfset variables.UserID = arguments.Value />
	</cffunction>

	<cffunction name="setDateTimePreviousLogin" access="private" output="false" hint="" >
		<cfargument name="Date" type="date" required="true" hint="" />

		<cfset variables.DateTimePreviousLogin = arguments.Date />
	</cffunction>

	<cffunction name="setDateCreated" access="private" output="false" hint="" >
		<cfargument name="Date" type="date" required="true" hint="" />

		<cfset variables.DateCreated = arguments.Date />
	</cffunction>

	<cffunction name="setDateTimeLastLogin" access="private" output="false" hint="" >
		<cfargument name="Time" type="date" required="true" hint="" />

		<cfset variables.DateTimeLastLogin = arguments.Time />
	</cffunction>

	<cffunction name="setPassword" access="private" output="false" hint="" >
		<cfargument name="Password" type="string" required="true" hint="" />

		<cfset variables.Password = arguments.Password />
	</cffunction>

	<cffunction name="setPasswordSalt" access="private" output="false" hint="" >
		<cfargument name="Salt" type="string" required="true" hint="" />

		<cfset variables.PasswordSalt = arguments.Salt />
	</cffunction>

	<cffunction name="setTempPassword" access="private" output="false" hint="" >
		<cfargument name="Password" type="string" required="true" hint="" />

		<cfset variables.TempPassword = arguments.Password />
	</cffunction>

	<cffunction name="setUserName" access="public" output="false" hint="" >
		<cfargument name="Name" type="string" required="true" hint="" />

		<cfset variables.UserName = arguments.Name />
	</cffunction>

	<cffunction name="setDisplayName" access="public" output="false" hint="" >
		<cfargument name="Name" type="string" required="true" hint="" />

		<cfset variables.DisplayName = arguments.Name />
	</cffunction>

	<cffunction name="setTimesLoggedIn" access="private" output="false" hint="" >
		<cfargument name="Count" type="numeric" required="true" hint="" />

		<cfset variables.TimesLoggedIn = arguments.Count />
	</cffunction>

	<cffunction name="setBrowserLastUsed" access="public" output="false" hint="" >
		<cfargument name="UserAgentString" type="string" required="true" hint="" />

		<cfset variables.BrowserLastUsed = arguments.UserAgentString />
	</cffunction>

	<cffunction name="setBlocked" access="public" output="false" hint="" >
		<cfargument name="Blocked" type="boolean" required="true" hint="" />

		<cfset variables.Blocked = arguments.Blocked />
	</cffunction>

	<cffunction name="setAuthKey" access="public" output="false" hint="" >
		<cfargument name="AuthKey" type="string" required="true" hint="" />

		<cfset variables.AuthKey = arguments.AuthKey />
	</cffunction>

	<!--- Methods --->

	<cffunction name="changePassword" returntype="void" access="public" output="false" hint="" >
		<cfargument name="SecurityManager" type="Components.SecurityManager" required="true" hint="A reference to an instance of the SecurityManager object" />
		<cfargument name="Password" type="string" required="false" default="" hint="The new password, in plain text (non-hashed)" />
		<cfargument name="TempPassword" type="boolean" required="false" default="false" hint="Whether this is a temporary password or not" />

		<cfset variables.onStatic() />

		<cfset var NewPassword = "" />
		<cfset var NewPasswordHashed = "" />
		<cfset var NewPasswordSalt = arguments.SecurityManager.getSaltedString() />
		<cfset var NewFinalPassword = "" />

		<cfif len( trim(arguments.Password) ) IS 0 >
			<cfset NewPassword = arguments.SecurityManager.createPassword() />
		<cfelse>
			<cfset NewPassword = arguments.Password />
		</cfif>

		<cfif arguments.TempPassword IS false >

			<cfset NewPasswordHashed = arguments.SecurityManager.getHashedString( StringData=NewPassword ) />
			<cfset NewFinalPassword = arguments.SecurityManager.getHashedString( StringData=(NewPasswordHashed & NewPasswordSalt) ) />

			<cfset setPassword( Password=NewFinalPassword ) />
			<cfset setPasswordSalt( Salt=NewPasswordSalt ) />

		<cfelse>
			<cfset setTempPassword( Password=NewPassword ) />
		</cfif>
	</cffunction>

	<cffunction name="validatePassword" returntype="boolean" access="public" output="false" hint="Checks the password you pass against the user's password" >
		<cfargument name="SecurityManager" type="Components.SecurityManager" required="true" hint="A reference to an instance of the SecurityManager object" />
		<cfargument name="Password" type="string" required="true" default="" hint="The password to validate, unhashed" />

		<cfset variables.onStatic() />

		<cfset var HashedPassword = "" />
		<cfset var HashedAndSaltedPassword = "" />
		<cfset var UsersPassword = getPassword() />
		<cfset var UsersPasswordSalt = getPasswordSalt() />

		<cfset HashedPassword = arguments.SecurityManager.getHashedString( StringData=arguments.Password ) />
		<cfset HashedAndSaltedPassword = arguments.SecurityManager.getHashedString( StringData=(HashedPassword & UsersPasswordSalt) ) />

		<cfif UsersPassword IS HashedAndSaltedPassword >
			<cfreturn true>
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>

	<cffunction name="updateLoginStats" returntype="void" access="public" output="false" hint="Updates the login count and datetime of last login. Should be called whenever the user successfully logs in." >
		<cfargument name="UserAgentString" type="string" required="true" hint="The user agent string of the user logging in" />

		<cfset variables.onStatic() />

		<cfset var CurrentLoginCount = getTimesLoggedIn() />
		<cfset setTimesLoggedIn( Count=CurrentLoginCount+1 ) />

		<cfset setDateTimePreviousLogin( Date=getDateTimeLastLogin() ) />

		<cfset setDateTimeLastLogin( Time=createODBCDateTime(now()) ) />
		<cfset setBrowserLastUsed( UserAgentString=arguments.UserAgentString ) />
	</cffunction>

	<cffunction name="save" returntype="boolean" access="public" output="false" hint="Persists the current state of the user to the db" >

		<cfset variables.onStatic() />

		<cfset var UpdateUser = queryNew("") />
		
		<cftransaction action="begin" >
			<cftry>
				<cfquery name="UpdateUser" datasource="#getDatasource()#" >
					UPDATE #getTableName()#
					SET	
						DateCreated = <cfqueryparam sqltype="DATE" value="#getDateCreated()#" />,
						DateTimeLastLogin = <cfqueryparam sqltype="TIMESTAMP" value="#getDateTimeLastLogin()#" />,
						Password = <cfqueryparam sqltype="LONGVARCHAR" value="#getPassword()#" maxlength="128" />,
						PasswordSalt = <cfqueryparam sqltype="LONGVARCHAR" value="#getPasswordSalt()#" maxlength="128" />,
						TempPassword = <cfqueryparam sqltype="LONGVARCHAR" value="#getTempPassword()#" />,
						UserName = <cfqueryparam sqltype="LONGVARCHAR" value="#getUserName()#" />,
						DisplayName = <cfqueryparam sqltype="LONGVARCHAR" value="#getDisplayName()#" />,
						TimesLoggedIn = <cfqueryparam sqltype="INTEGER" value="#getTimesLoggedIn()#" />,
						BrowserLastUsed = <cfqueryparam sqltype="LONGVARCHAR" value="#getBrowserLastUsed()#" />,
						Blocked = <cfqueryparam sqltype="BOOLEAN" value="#getBlocked()#" />

					WHERE #getTableKey()# = <cfqueryparam sqltype="BIGINT" value="#getID()#" />;
				</cfquery>

				<cftransaction action="commit" />

				<cfset load() />
				<cfreturn true />
			<cfcatch>

				<cftransaction action="rollback" />
				<cfthrow object="#cfcatch#" />
				<cfreturn false />

			</cfcatch>
			</cftry>
		</cftransaction>
	</cffunction>

	<cffunction name="create" returntype="Models.User" access="public" hint="Static method. Creates a new empty user in the db and returns an instance of this user" >
		<cfargument name="Username" type="string" required="true" hint="The login name for the new user." />
		<cfargument name="Datasource" type="string" required="true" hint="The name of the datasource to use for queries." />

		<cfset variables.onInitialized() />
		<cfset variables.setupTableColumns( Datasource=trim(arguments.Datasource) ) />

		<cfif len(arguments.Username) IS 0 >
			<cfthrow message="Error creating new user" detail="The username you passed is empty, this is not allowed." />
		</cfif>

		<cfif len(arguments.Datasource) IS 0 >
			<cfthrow message="Error creating new user" detail="The datasource name you passed is empty, this is not allowed." />
		</cfif>

		<cfset variables.setDisplayName(Name="New user XYZ#randRange(1, 100)#") />
		<cfset variables.setUserName(Name=arguments.Username) />

		<cfset var CreateUser = queryNew("") />

		<cfset setDateCreated( Date=createODBCdate(now()) ) />

		<cftransaction action="begin" >
			<cftry>
				<cfquery name="CreateUser" datasource="#arguments.Datasource#" >
					INSERT INTO #getTableName()# (
						DateCreated,
						DateTimeLastLogin,
						Password,
						PasswordSalt,
						TempPassword,
						UserName,
						DisplayName,
						TimesLoggedIn,
						BrowserLastUsed,
						Blocked
					)
					VALUES (
						<cfqueryparam sqltype="DATE" value="#getDateCreated()#" />,
						<cfqueryparam sqltype="TIMESTAMP" value="#getDateTimeLastLogin()#" />,
						<cfqueryparam sqltype="LONGVARCHAR" value="#getPassword()#" />,
						<cfqueryparam sqltype="LONGVARCHAR" value="#getPasswordSalt()#" />,
						<cfqueryparam sqltype="LONGVARCHAR" value="#getTempPassword()#" />,
						<cfqueryparam sqltype="LONGVARCHAR" value="#getUserName()#" />,
						<cfqueryparam sqltype="LONGVARCHAR" value="#getDisplayName()#" />,
						<cfqueryparam sqltype="INTEGER" value="#getTimesLoggedIn()#" />,
						<cfqueryparam sqltype="LONGVARCHAR" value="#getBrowserLastUsed()#" />,
						<cfqueryparam sqltype="BOOLEAN" value="#getBlocked()#" />
					)
					RETURNING #getTableKey()#; 
				</cfquery>

				<cftransaction action="commit" />
			<cfcatch>

				<cftransaction action="rollback" />
				<cfthrow object="#cfcatch#" />

			</cfcatch>
			</cftry>
		</cftransaction>

		<cfreturn variables.init(
			ID=CreateUser[ getTableKey() ],
			Datasource=arguments.Datasource
		) />
	</cffunction>

	<cffunction name="load" returntype="boolean" access="private" output="false" hint="Fills the instance with data from the db." >

		<cfset var UserData = queryNew("") />

		<cfquery name="UserData" datasource="#getDatasource()#" >
			SELECT #getTableColumns()#
			FROM #getTableName()#
			WHERE #getTableKey()# = <cfqueryparam sqltype="BIGINT" value="#getID()#" />
		</cfquery>

		<cfif UserData.RecordCount GT 0 >
			<cfset setDateCreated( Date=UserData.DateCreated ) />
			<cfset setDateTimeLastLogin( Time=UserData.DateTimeLastLogin ) />
			<cfset setPassword( Password=UserData.Password ) />
			<cfset setPasswordSalt( Salt=UserData.PasswordSalt ) />
			<cfset setTempPassword( Password=UserData.TempPassword ) />
			<cfset setUserName( Name=UserData.UserName ) />
			<cfset setDisplayName( Name=UserData.DisplayName ) />
			<cfset setTimesLoggedIn( Count=UserData.TimesLoggedIn ) />
			<cfset setBrowserLastUsed( UserAgentString=UserData.BrowserLastUsed ) />
			<cfset setBlocked( Blocked=UserData.Blocked ) />
		<cfelse>
			<cfthrow message="Error when loading user data. There appears to be no userdata with this #getTableKey()#: #getID()#" />
			<cfreturn false />
		</cfif>

		<cfreturn true />
	</cffunction>

	<cffunction name="init" access="public" returntype="Models.User" output="false" hint="Constructor, returns an initialized user who is by default blocked." >
		<cfargument name="ID" type="numeric" required="true" hint="The UserID of the user you want to init this instance with." />
		<cfargument name="Datasource" type="string" required="true" hint="The name of the datasource to use for queries." />

		<cfset variables.onInitialized() />

		<cfif len(arguments.Datasource) IS 0 >
			<cfthrow message="Error when initializing user. The datasource argument appears to be empty" />
		</cfif>

		<cfset variables.setDataSource( Name= trim(arguments.Datasource) ) />
		<cfset variables.setupTableColumns( Datasource=trim(arguments.Datasource) ) />

		<cfif variables.exists( ID=arguments.ID, Datasource=arguments.Datasource ) IS false >
			<cfthrow message="Error when initializing user. No user with this #variables.getTableKey()# exists: #arguments.ID#" />
		</cfif>

		<cfset variables.setID( Value=arguments.ID ) >
		<cfset variables.load() />

		<cfset variables.IsStatic = false />

		<cfreturn this />
	</cffunction>

</cfcomponent>