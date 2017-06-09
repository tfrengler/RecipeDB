<cfcomponent output="false" extends="Model" >
<cfprocessingdirective pageEncoding="utf-8" />

	<cfset UserID = 0 />
	<cfset DateCreated = createDate(1666, 6, 6) />
	<cfset DateTimePreviousLogin = createDateTime(1666, 6, 6, 6, 6, 6) />
	<cfset DateTimeLastLogin = createDateTime(1666, 6, 6, 6, 6, 6) />
	<cfset Password = "" />
	<cfset TempPassword = "" />
	<cfset UserName = "" />
	<cfset DisplayName = "" />
	<cfset TimesLoggedIn = 0 />
	<cfset BrowserLastUsed = "" />
	<cfset Blocked = true />

	<cfset TableName = "Users" />
	<cfset TableKey = "UserID" />
	<cfset TableColumns = "DateCreated,DateTimeLastLogin,Password,TempPassword,UserName,DisplayName,TimesLoggedIn,BrowserLastUsed,Blocked" />

	<!--- Getters --->

	<cffunction name="getUserID" access="public" returntype="numeric" output="false" hint="" >
		<cfreturn UserID />
	</cffunction>

	<cffunction name="getDateTimePreviousLogin" access="public" returntype="date" output="false" hint="" >
		<cfset onStatic() />

		<cfreturn DateTimePreviousLogin />
	</cffunction>

	<cffunction name="getDateCreated" access="public" returntype="date" output="false" hint="" >
		<cfset onStatic() />

		<cfreturn DateCreated />
	</cffunction>

	<cffunction name="getDateTimeLastLogin" access="public" returntype="date" output="false" hint="" >
		<cfset onStatic() />

		<cfreturn DateTimeLastLogin />
	</cffunction>

	<cffunction name="getPassword" access="public" returntype="string" output="false" hint="" >
		<cfset onStatic() />

		<cfreturn Password />
	</cffunction>

	<cffunction name="getTempPassword" access="public" returntype="string" output="false" hint="" >
		<cfset onStatic() />

		<cfreturn TempPassword />
	</cffunction>

	<cffunction name="getUserName" access="public" returntype="string" output="false" hint="" >
		<cfset onStatic() />

		<cfreturn UserName />
	</cffunction>

	<cffunction name="getDisplayName" access="public" returntype="string" output="false" hint="" >
		<cfset onStatic() />

		<cfreturn DisplayName />
	</cffunction>

	<cffunction name="getTimesLoggedIn" access="public" returntype="numeric" output="false" hint="" >
		<cfset onStatic() />

		<cfreturn TimesLoggedIn />
	</cffunction>

	<cffunction name="getBrowserLastUsed" access="public" returntype="string" output="false" hint="" >
		<cfset onStatic() />

		<cfreturn BrowserLastUsed />
	</cffunction>

	<cffunction name="getBlocked" access="public" returntype="boolean" output="false" hint="" >
		<cfset onStatic() />

		<cfreturn Blocked />
	</cffunction>

	<!--- Setters --->

	<cffunction name="setUserID" access="private" output="false" hint="" >
		<cfargument name="ID" type="numeric" required="true" hint="" />

		<cfset variables.UserID = arguments.ID />
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

		<cfif len(arguments.Password) LT 8 >
			<cfthrow message="Password must be bigger than 8 characters" />
		</cfif>

		<cfset variables.Password = arguments.Password />
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

	<!--- Methods --->

	<cffunction name="changePassword" returntype="void" access="public" output="false" hint="" >
		<cfargument name="SecurityManager" type="Models.SecurityManager" required="true" hint="A reference to an instance of the SecurityManager object" />
		<cfargument name="Password" type="string" required="false" default="" hint="The new password, in plain text (non-hashed)" />
		<cfargument name="TempPassword" type="boolean" required="false" default="false" hint="Whether this is a temporary password or not" />

		<cfset onStatic() />

		<cfset var Security = arguments.SecurityManager />
		<cfset var NewPassword = "" />
		<cfset var NewPasswordHashed = "" />

		<cfif len( trim(arguments.Password) ) IS 0 >
			<cfset NewPassword = Security.createPassword() />
		<cfelse>
			<cfset NewPassword = arguments.Password />
		</cfif>

		<cfif arguments.TempPassword IS false >
			<cfset NewPasswordHashed = Security.getHashedString( StringData=NewPassword ) />
			<cfset setPassword( Password=NewPasswordHashed ) />
		<cfelse>
			<cfset setTempPassword( Password=NewPassword ) />
		</cfif>
	</cffunction>

	<cffunction name="validatePassword" returntype="boolean" access="public" output="false" hint="Checks the password you pass against the user's password" >
		<cfargument name="SecurityManager" type="Models.SecurityManager" required="true" hint="A reference to an instance of the SecurityManager object" />
		<cfargument name="Password" type="string" required="true" default="" hint="The password to validate, unhashed" />

		<cfset onStatic() />

		<cfset var Security = arguments.SecurityManager />
		<cfset var HashedPassword = "" />
		<cfset var UsersPassword = getPassword() />

		<cfset HashedPassword = Security.getHashedString( StringData=trim(arguments.Password) ) />

		<cfif UsersPassword IS HashedPassword >
			<cfreturn true>
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>

	<cffunction name="delete" returntype="void" access="public" output="false" hint="Delete the db data belonging to this object instance" >
		<cfset onStatic() />

		<cfset var DeleteUser = queryNew("") />
		<cfquery name="DeleteUser" datasource="#getDatasource()#" >
			DELETE *
			FROM #getTableName()#
			WHERE #getTableKey()# = <cfqueryparam sqltype="BIGINT" value="#getUserID()#" />
		</cfquery>
	</cffunction>

	<cffunction name="updateLoginStats" returntype="void" access="public" output="false" hint="Updates the login count and datetime of last login. Should be called whenever the user successfully logs in." >
		<cfargument name="UserAgentString" type="string" required="true" hint="The user agent string of the user logging in" />

		<cfset onStatic() />

		<cfset var CurrentLoginCount = getTimesLoggedIn() />
		<cfset setTimesLoggedIn( Count=CurrentLoginCount+1 ) />

		<cfset setDateTimePreviousLogin( Date=getDateTimeLastLogin() ) />

		<cfset setDateTimeLastLogin( Time=createODBCDateTime(now()) ) />
		<cfset setBrowserLastUsed( UserAgentString=arguments.UserAgentString ) />
	</cffunction>

	<cffunction name="exists" returntype="boolean" access="public" output="false" hint="Static method. Checks whether the object exists or not in the db" >
		<cfargument name="ID" type="numeric" required="true" hint="ID of the user you want to check for" />

		<cfset onInitialized() />

		<cfset var ExistenceCheck = queryNew("") />

		<cfquery name="ExistenceCheck" datasource="#getDatasource()#" >
			SELECT #getTableKey()#
			FROM #getTableName()#
			WHERE #getTableKey()# = <cfqueryparam sqltype="BIGINT" value="#arguments.ID#" />
		</cfquery>

		<cfif ExistenceCheck.RecordCount IS 1 >
			<cfreturn true />
		</cfif>

		<cfreturn false />
	</cffunction>

	<cffunction name="save" returntype="boolean" access="public" output="false" hint="Persists the current state of the user to the db" >

		<cfset onStatic() />

		<cfset var UpdateUser = queryNew("") />
		
		<cftransaction action="begin" >
			<cftry>
				<cfquery name="UpdateUser" datasource="#getDatasource()#" >
					UPDATE #getTableName()#
					SET	
						DateCreated = <cfqueryparam sqltype="DATE" value="#getDateCreated()#" />,
						DateTimeLastLogin = <cfqueryparam sqltype="TIMESTAMP" value="#getDateTimeLastLogin()#" />,
						Password = <cfqueryparam sqltype="LONGVARCHAR" value="#getPassword()#" />,
						TempPassword = <cfqueryparam sqltype="LONGVARCHAR" value="#getTempPassword()#" />,
						UserName = <cfqueryparam sqltype="LONGVARCHAR" value="#getUserName()#" />,
						DisplayName = <cfqueryparam sqltype="LONGVARCHAR" value="#getDisplayName()#" />,
						TimesLoggedIn = <cfqueryparam sqltype="INTEGER" value="#getTimesLoggedIn()#" />,
						BrowserLastUsed = <cfqueryparam sqltype="LONGVARCHAR" value="#getBrowserLastUsed()#" />,
						Blocked = <cfqueryparam sqltype="BOOLEAN" value="#getBlocked()#" />

					WHERE #getTableKey()# = <cfqueryparam sqltype="BIGINT" value="#getUserID()#" />;
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

		<cfset onInitialized() />

		<cfset var CreateUser = queryNew("") />

		<cfset setDateCreated( Date=createODBCdate(now()) ) />

		<cftransaction action="begin" >
			<cftry>
				<cfquery name="CreateUser" datasource="#getDatasource()#" >
					INSERT INTO #getTableName()# (
						DateCreated,
						DateTimeLastLogin,
						Password,
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

		<cfset setUserID( ID=CreateUser[ getTableKey() ] ) />

		<cfreturn this />
	</cffunction>

	<cffunction name="load" returntype="boolean" access="private" output="false" hint="Fills the instance with data from the db." >

		<cfset var UserData = queryNew("") />

		<cfquery name="UserData" datasource="#getDatasource()#" >
			SELECT #getTableKey()#
			FROM #getTableName()#
			WHERE #getTableKey()# = <cfqueryparam sqltype="BIGINT" value="#getUserID()#" />
		</cfquery>

		<cfif UserData.RecordCount GT 0 >
			<cfset setDateCreated( Date=UserData.DateCreated ) />
			<cfset setDateTimeLastLogin( Time=UserData.DateTimeLastLogin ) />
			<cfset setPassword( Password=UserData.Password ) />
			<cfset setTempPassword( Password=UserData.TempPassword ) />
			<cfset setUserName( Name=UserData.UserName ) />
			<cfset setDisplayName( Name=UserData.DisplayName ) />
			<cfset setTimesLoggedIn( Count=UserData.TimesLoggedIn ) />
			<cfset setBrowserLastUsed( UserAgentString=UserData.BrowserLastUsed ) />
			<cfset setBlocked( Blocked=UserData.Blocked ) />
		<cfelse>
			<cfthrow message="Error when loading user data. There appears to be no userdata with this #getTableKey()#: #getUserID()#" />
			<cfreturn false />
		</cfif>

		<cfreturn true />
	</cffunction>

	<cffunction name="getData" returntype="any" access="public" output="false" hint="Static method. Fetch data from a specific user or multiple users." >
		<cfargument name="ColumnList" type="string" required="false" default="" hint="List of columns you want to fetch data from." />
		<cfargument name="ID" type="numeric" required="false" default="0" hint="ID of the user you want to fetch data for. If you leave this out you get all users." />
		<cfargument name="Datasource" type="string" required="true" hint="The name of the datasource to use for queries." />

		<cfset onInitialized() />

		<cfset var ObjectData = queryNew("") />
		<cfset var CurrentColumn = "" />
		<cfset var Columns = "" />

		<cfif len(arguments.ColumnList) GT 0 >

			<cfloop list="#arguments.ColumnList#" index="CurrentColumn" >
				<cfif listFindNoCase("#getTableKey()#,#getTableColumns()#", CurrentColumn) IS 0 >
					<cfthrow message="The column '#CurrentColumn#' you are trying to get data for is not a valid column in the #getTableName()#-table. Valid columns are: #getTableColumns()#" />
				</cfif>
			</cfloop>

			<cfset Columns = arguments.ColumnList />
		<cfelse>
			<cfset Columns = "#getTableKey()#,#getTableColumns()#" />
		</cfif>

		<cfquery name="ObjectData" datasource="#arguments.Datasource#" >
			SELECT #Columns#
			FROM #getTableName()#
			<cfif arguments.ID GT 0 >
			WHERE #getTableKey()# = <cfqueryparam sqltype="BIGINT" value="#arguments.ID#" />
			</cfif>
		</cfquery>

		<cfreturn ObjectData />
	</cffunction>
 
	<cffunction name="getByUsername" returntype="numeric" access="public" output="false" hint="Static method. Search for a user by username and returns the ID. Returns 0 if nothing is found" >
		<cfargument name="Datasource" type="string" required="true" hint="The name of the datasource to use for queries." />
		<cfargument name="Username" type="string" required="true" hint="The name of the user you're searching for" />

		<cfset onInitialized() />

		<cfset var SearchResult = queryNew("") />
		<cfset var ReturnData = 0 />

		<cfquery name="SearchResult" datasource="#trim(arguments.Datasource)#" >
			SELECT #getTableKey()#
			FROM #getTableName()#
			WHERE UserName = <cfqueryparam sqltype="LONGVARCHAR" value="#trim(arguments.Username)#" />
		</cfquery>

		<cfif SearchResult.RecordCount GT 0 >
			<cfset ReturnData = SearchResult[ getTableKey() ] />
		</cfif>

		<cfreturn ReturnData />
	</cffunction>

	<cffunction name="init" access="public" returntype="Models.User" output="false" hint="Constructor, returns an initialized user." >
		<cfargument name="ID" type="numeric" required="true" hint="The UserID of the user you want to init this instance with." />
		<cfargument name="Datasource" type="string" required="true" hint="The name of the datasource to use for queries." />

		<cfif len(arguments.Datasource) IS 0 >
			<cfthrow message="Error when initializing user. The datasource argument appears to be empty" />
		</cfif>

		<cfset variables.setDataSource( Name= trim(arguments.Datasource) ) />

		<cfif variables.exists( ID=arguments.ID ) IS false >
			<cfthrow message="Error when initializing user. No user with this #getTableKey()# exists: #arguments.ID#" />
		</cfif>

		<cfset variables.setUserID( ID=arguments.ID ) >
		<cfset variables.load() />

		<cfset variables.IsStatic = false />

		<cfreturn this />
	</cffunction>

</cfcomponent>