<cfcomponent output="false" >
<cfprocessingdirective pageEncoding="utf-8"  />

	<cfset UserID = 0 />
	<cfset DateCreated = createDate(1666, 6, 6) />
	<cfset DateTimeLastLogin = createDateTime(1666, 6, 6, 6, 6, 6) />
	<cfset Password = "" />
	<cfset TempPassword = "" />
	<cfset UserName = "" />
	<cfset DisplayName = "" />
	<cfset TimesLoggedIn = 0 />
	<cfset BrowserLastUsed = "" />
	<cfset Blocked = true />

	<cfset DatasourceName = "" />
	<cfset IsStatic = true />
	<cfset TableColumns = "" />

	<!--- Getters --->

	<cffunction name="getUserID" access="public" returntype="numeric" output="false" hint="" >
		<cfreturn UserID />
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

	<cffunction name="getDatasource" access="public" returntype="string" output="false" hint="" >
		<cfreturn DatasourceName />
	</cffunction>

	<!--- Table mappings --->

	<cffunction name="mapTableColumns" returntype="void" access="private" output="false" hint="" >
		<cfset var TableColumnQuery = queryNew("") />
		
		<cfquery name="TableColumnQuery" datasource="dev" cachedwithin="#createTimespan(0, 1, 0, 0)#" >
			SELECT *
			FROM #getTableName()#
			WHERE #getTableKey()# = <cfqueryparam sqltype="BIGINT" value="0" />
		</cfquery>

		<cfset TableColumns = TableColumnQuery.ColumnList() />
	</cffunction> 

	<cffunction name="getTableName" returntype="string" access="public" output="false" hint="" >
		<cfreturn "Users" />
	</cffunction> 

	<cffunction name="getTableKey" returntype="string" access="public" output="false" hint="" >
		<cfreturn "UserID" />
	</cffunction>

	<cffunction name="getTableColumns" returntype="string" access="public" output="false" hint="" >
		<cfreturn TableColumns />
	</cffunction>

	<cfset mapTableColumns() />

	<!--- Static method support --->

	<cffunction name="onStatic" returntype="void" access="private" output="false" hint="" >
		<cfif IsStatic >
			<cfthrow message="Can't call this dynamic method because the instance is not initialized" />
		</cfif>
	</cffunction>

	<cffunction name="onInitialized" returntype="void" access="public" output="false" hint="" >
		<cfif IsStatic IS false >
			<cfthrow message="Can't call this static method because this instance is already initialized with id: #getUserID()#" />
		</cfif>
	</cffunction>

	<!--- Setters --->

	<cffunction name="setUserID" access="private" output="false" hint="" >
		<cfargument name="ID" type="numeric" required="true" hint="" />

		<cfset UserID = arguments.ID />
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

		<cfset variables.Password = arguments.Password />
	</cffunction>

	<cffunction name="setTempPassword" access="private" output="false" hint="" >
		<cfargument name="Password" type="string" required="true" hint="" />

		<cfset TempPassword = arguments.Password />
	</cffunction>

	<cffunction name="setUserName" access="public" output="false" hint="" >
		<cfargument name="Name" type="string" required="true" hint="" />

		<cfset UserName = arguments.Name />
	</cffunction>

	<cffunction name="setDisplayName" access="public" output="false" hint="" >
		<cfargument name="Name" type="string" required="true" hint="" />

		<cfset DisplayName = arguments.Name />
	</cffunction>

	<cffunction name="setTimesLoggedIn" access="private" output="false" hint="" >
		<cfargument name="Count" type="numeric" required="true" hint="" />

		<cfset TimesLoggedIn = arguments.Count />
	</cffunction>

	<cffunction name="setBrowserLastUsed" access="public" output="false" hint="" >
		<cfargument name="UserAgentString" type="string" required="true" hint="" />

		<cfset BrowserLastUsed = arguments.UserAgentString />
	</cffunction>

	<cffunction name="setBlocked" access="public" output="false" hint="" >
		<cfargument name="Blocked" type="boolean" required="true" hint="" />

		<cfset variables.Blocked = arguments.Blocked />
	</cffunction>

	<cffunction name="setDataSource" access="private" output="false" hint="" >
		<cfargument name="Name" type="string" required="true" hint="" />

		<cfset DatasourceName = arguments.Name />
	</cffunction>

	<!--- Methods --->

	<cffunction name="changePassword" returntype="void" access="public" output="false" hint="" >
		<cfargument name="SecurityManager" type="Components.SecurityManager" required="true" hint="A reference to an instance of the SecurityManager object" />
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

	<cffunction name="delete" returntype="void" access="public" output="false" hint="Delete the db data belonging to this object instance" >
		<cfset onStatic() />

		<cfset var DeleteUser = queryNew("") />
		<cfquery name="DeleteUser" datasource="#getDatasource()#" >
			DELETE *
			FROM #getTableName()#
			WHERE #getTableKey()# = <cfqueryparam sqltype="BIGINT" value="#getUserID()#" />
		</cfquery>
	</cffunction>

	<cffunction name="onLogin" returntype="void" access="public" output="false" hint="Updates the login count and datetime of last login. Should be called whenever the user successfully logs in." >
		<cfset onStatic() />

		<cfset var CurrentLoginCount = getTimesLoggedIn() />
		<cfset setTimesLoggedIn( Count=CurrentLoginCount+1 ) />

		<cfset setDateTimeLastLogin( Time=createODBCDateTime(now()) ) />
	</cffunction>

	<cffunction name="exists" returntype="boolean" access="public" output="false" hint="Checks whether the object exists or not in the db. Can be used on both initialized and non-initialized objects." >
		<cfargument name="ID" type="numeric" required="false" default="0" hint="If you don't pass in an ID it will use the ID of the current instance. If the instance is not initialized it will always return false" />

		<cfset var ExistenceCheck = queryNew("") />

		<cfquery name="ExistenceCheck" datasource="#getDatasource()#" >
			SELECT #getTableKey()#
			FROM #getTableName()#
			WHERE #getTableKey()# = 
			<cfif arguments.ID GT 0 >
				<cfqueryparam sqltype="BIGINT" value="#arguments.ID#" />
			<cfelse>
				<cfqueryparam sqltype="BIGINT" value="#getUserID()#" />
			</cfif>
		</cfquery>

		<cfif ExistenceCheck.RecordCount IS 1 >
			<cfreturn true />
		</cfif>

		<cfreturn false />
	</cffunction>

	<cffunction name="save" returntype="boolean" access="public" output="false" hint="Persists the current state of the user to the db" >

		<cfset onStatic() />

		<cfif exists( ID=getUserID() ) IS false >
			<cfthrow message="You can't update a user that doesn't exist: #getUserID()#" />
			<cfreturn false />
		</cfif>

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

	<cffunction name="load" returntype="boolean" access="private" output="false" hint="Fills this objects instance with data from the db" >

		<cfset var UserData = queryNew("") />

		<cfquery name="UserData" datasource="#getDatasource()#" >
			SELECT DateCreated, DateTimeLastLogin, Password, TempPassword, UserName, DisplayName, TimesLoggedIn, BrowserLastUsed, Blocked
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

	<cffunction name="getData" returntype="struct" access="public" output="false" hint="" >
		<cfargument name="ColumnList" type="string" required="false" default="*" hint="" />
		<cfargument name="ID" type="numeric" required="false" default="0" hint="" />

		<cfset onInitialized() />

		<cfset var RecipeData = queryNew("") />
		<cfset var CurrentColumn = "" />

		<cfif arguments.ColumnList IS NOT "*" >

			<cfloop list="#arguments.ColumnList#" index="CurrentColumn" >
				<cfif listFindNoCase(getTableColumns(), CurrentColumn) IS 0 >
					<cfthrow message="This column you are trying to get data for is not a valid column in the #getTableName()#-table: #CurrentColumn#" />
				</cfif>
			</cfloop>

		</cfif>

		<cfquery name="RecipeData" datasource="#getDatasource()#" >
			SELECT #arguments.ColumnList#
			FROM #getTableName()#
			<cfif arguments.ID GT 0 >
			WHERE #getTableKey()# = <cfqueryparam sqltype="BIGINT" value="#arguments.ID#" />
			</cfif>
		</cfquery>
	</cffunction>

	<cffunction name="init" access="public" returntype="Components.User" output="false" hint="Constructor, returns an initialized user." >
		<cfargument name="ID" type="numeric" required="true" hint="The UserID of the user you want to init this instance with." />
		<cfargument name="Datasource" type="string" required="true" hint="The name of the datasource to use for queries." />

		<cfset setDataSource( Name=arguments.Datasource ) />

		<cfif exists( ID=arguments.ID ) IS false >
			<cfthrow message="Error when initializing user. No user with this #getTableKey()# exists: #arguments.ID#" />
		</cfif>

		<cfset IsStatic = false />

		<cfset setUserID( ID=arguments.ID ) >
		<cfset load() />

		<cfreturn this />
	</cffunction>

</cfcomponent>