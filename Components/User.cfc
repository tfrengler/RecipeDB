<cfcomponent output="false" >
<cfprocessingdirective pageEncoding="utf-8"  />

	<cfset UserID = 0 />
	<cfset SessionID = "" />
	<cfset DateCreated = createDate(666, 6, 6) />
	<cfset DateTimeLastLogin = createDateTime(666, 6, 6, 6, 6, 6) />
	<cfset Password = "" />
	<cfset TempPassword = "" />
	<cfset UserName = "" />
	<cfset DisplayName = "" />
	<cfset TimesLoggedIn = 0 />
	<cfset BrowserLastUsed = "" />
	<cfset Blocked = false />
	<cfset IsStatic = true />

	<!--- Getters --->

	<cffunction name="getUserID" access="public" output="false" hint="" >
		<cfif IsStatic IS false >
			<cfthrow message="Can't call method because this instance is already initialized with id: #getUserID()#" />
		</cfif>

		<cfreturn UserID />
	</cffunction>

	<cffunction name="getSessionID" access="public" output="false" hint="" >
		<cfif IsStatic IS false >
			<cfthrow message="Can't call method because this instance is already initialized with id: #getUserID()#" />
		</cfif>

		<cfreturn SessionID />
	</cffunction>

	<cffunction name="getDateCreated" access="public" output="false" hint="" >
		<cfif IsStatic IS false >
			<cfthrow message="Can't call method because this instance is already initialized with id: #getUserID()#" />
		</cfif>

		<cfreturn DateCreated />
	</cffunction>

	<cffunction name="getDateTimeLastLogin" access="public" output="false" hint="" >
		<cfif IsStatic IS false >
			<cfthrow message="Can't call method because this instance is already initialized with id: #getUserID()#" />
		</cfif>

		<cfreturn DateTimeLastLogin />
	</cffunction>

	<cffunction name="getPassword" access="public" output="false" hint="" >
		<cfif IsStatic IS false >
			<cfthrow message="Can't call method because this instance is already initialized with id: #getUserID()#" />
		</cfif>

		<cfreturn Password />
	</cffunction>

	<cffunction name="getTempPassword" access="public" output="false" hint="" >
		<cfif IsStatic IS false >
			<cfthrow message="Can't call method because this instance is already initialized with id: #getUserID()#" />
		</cfif>

		<cfreturn TempPassword />
	</cffunction>

	<cffunction name="getUserName" access="public" output="false" hint="" >
		<cfif IsStatic IS false >
			<cfthrow message="Can't call method because this instance is already initialized with id: #getUserID()#" />
		</cfif>

		<cfreturn UserName />
	</cffunction>

	<cffunction name="getDisplayName" access="public" output="false" hint="" >
		<cfif IsStatic IS false >
			<cfthrow message="Can't call method because this instance is already initialized with id: #getUserID()#" />
		</cfif>

		<cfreturn DisplayName />
	</cffunction>

	<cffunction name="getTimesLoggedIn" access="public" output="false" hint="" >
		<cfif IsStatic IS false >
			<cfthrow message="Can't call method because this instance is already initialized with id: #getUserID()#" />
		</cfif>

		<cfreturn TimesLoggedIn />
	</cffunction>

	<cffunction name="getBrowserLastUsed" access="public" output="false" hint="" >
		<cfif IsStatic IS false >
			<cfthrow message="Can't call method because this instance is already initialized with id: #getUserID()#" />
		</cfif>

		<cfreturn BrowserLastUsed />
	</cffunction>

	<cffunction name="getBlocked" access="public" output="false" hint="" >
		<cfif IsStatic IS false >
			<cfthrow message="Can't call method because this instance is already initialized with id: #getUserID()#" />
		</cfif>

		<cfreturn Blocked />
	</cffunction>

	<cffunction name="getTableName" access="public" output="false" hint="" >
		<cfif IsStatic IS false >
			<cfthrow message="Can't call method because this instance is already initialized with id: #getUserID()#" />
		</cfif>

		<cfreturn "Users" />
	</cffunction> 

	<cffunction name="getTableKey" access="public" output="false" hint="" >
		<cfif IsStatic IS false >
			<cfthrow message="Can't call method because this instance is already initialized with id: #getUserID()#" />
		</cfif>

		<cfreturn "UserID" />
	</cffunction>

	<!--- Setters --->

	<cffunction name="setUserID" access="private" output="false" hint="" >
		<cfargument name="ID" type="numeric" required="true" hint="" />

		<cfset UserID = arguments.ID />
	</cffunction>

	<cffunction name="setSessionID" access="private" output="false" hint="" >
		<cfargument name="UUID" type="uuid" required="true" hint="" />

		<cfset SessionID = arguments.UUID />
	</cffunction>

	<cffunction name="setDateCreated" access="private" output="false" hint="" >
		<cfargument name="Date" type="date" required="true" hint="" />

		<cfset DateCreated = arguments.Date />
	</cffunction>

	<cffunction name="setDateTimeLastLogin" access="private" output="false" hint="" >
		<cfargument name="Time" type="date" required="true" hint="" />

		<cfset DateTimeLastLogin = arguments.Time />
	</cffunction>

	<cffunction name="setPassword" access="private" output="false" hint="" >
		<cfargument name="Password" type="string" required="true" hint="" />

		<cfset Password = arguments.Password />
	</cffunction>

	<cffunction name="setTempPassword" access="private" output="false" hint="" >
		<cfargument name="Password" type="string" required="true" hint="" />

		<cfset TempPassword = arguments.Password />
	</cffunction>

	<cffunction name="setUserName" access="private" output="false" hint="" >
		<cfargument name="Name" type="string" required="true" hint="" />

		<cfset UserName = arguments.Name />
	</cffunction>

	<cffunction name="setDisplayName" access="private" output="false" hint="" >
		<cfargument name="Name" type="string" required="true" hint="" />

		<cfset DisplayName = arguments.Name />
	</cffunction>

	<cffunction name="setTimesLoggedIn" access="private" output="false" hint="" >
		<cfargument name="Count" type="numeric" required="true" hint="" />

		<cfset TimesLoggedIn = arguments.Count />
	</cffunction>

	<cffunction name="setBrowserLastUsed" access="private" output="false" hint="" >
		<cfargument name="UserAgentString" type="string" required="true" hint="" />

		<cfset BrowserLastUsed = arguments.UserAgentString />
	</cffunction>

	<cffunction name="setBlocked" access="private" output="false" hint="" >
		<cfargument name="Blocked" type="boolean" required="true" hint="" />

		<cfset Blocked = arguments.Blocked />
	</cffunction>

	<!--- Methods --->

	<cffunction name="exists" returntype="boolean" access="public" output="false" hint="" >
		<cfargument name="ID" type="numeric" required="true" hint="" />

		<cfset var ExistenceCheck = queryNew("") />
		<cfquery name="ExistenceCheck" datasource="test" >
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

		<cfif IsStatic >
			<cfthrow message="Can't call this method because the instance is not initialized" />
		</cfif>

		<cfif exists( ID=getUserID() ) IS false >
			<cfthrow message="You can't update a user that doesn't exist: #getUserID()#" />
			<cfreturn false />
		</cfif>

		<cfset var UpdateUser = queryNew("") />
		
		<cftransaction action="begin" >
			<cftry>
				<cfquery name="UpdateUser" datasource="test" >
					UPDATE #getTableName()#
					SET	
						SessionID = <cfqueryparam sqltype="UUID" value="#getSessionID()#" />,
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
				<cfreturn true />
			<cfcatch>

				<cftransaction action="rollback" />
				<cfthrow object="#cfcatch#" />
				<cfreturn false />

			</cfcatch>
			</cftry>
		</cftransaction>
	</cffunction>

	<cffunction name="create" returntype="Components.User" access="public" hint="Creates a new empty user in the db and returns an instance of this user" >

		<cfif IsStatic IS false >
			<cfthrow message="Can't call method because this instance is already initialized with id: #getUserID()#" />
		</cfif>

		<cfset var CreateUser = queryNew("") />

		<cfset setDateCreated( Date=createODBCdate(now()) ) />

		<cftransaction action="begin" >
			<cftry>
				<cfquery name="CreateUser" datasource="test" >
					INSERT INTO #getTableName()# (
						SessionID,
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
						<cfqueryparam sqltype="UUID" value="#getSessionID()#" />,
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

	<cffunction name="load" returntype="boolean" access="private" output="false" hint="Fills this objects instance with data from the db" >

		<cfset var UserData = queryNew("") />

		<cfquery name="UserData" datasource="test" >
			SELECT SessionID, DateCreated, DateTimeLastLogin, Password, TempPassword, UserName, DisplayName, TimesLoggedIn, BrowserLastUsed, Blocked
			FROM #getTableName()#
			WHERE #getTableKey()# = <cfqueryparam sqltype="BIGINT" value="#getUserID()#" />
		</cfquery>

		<cfif UserData.RecordCount GT 0 >
			<cfset setSessionID( UUID=UserData.SessionID ) />
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

	<cffunction name="init" access="public" returntype="Components.Users" output="false" hint="Constructor, returns an initialized user." >
		<cfargument name="ID" type="numeric" required="true" hint="The UserID of the user you want to init this instance with" />

		<cfif exists( ID=arguments.ID ) IS false >
			<cfthrow message="Error when initializing user. No user with this #getTableKey()# exists: #arguments.ID#" />
		</cfif>

		<cfset setUserID( ID=arguments.ID ) >
		<cfset load() />

		<cfset IsStatic = false />

		<cfreturn this />
	</cffunction>

</cfcomponent>