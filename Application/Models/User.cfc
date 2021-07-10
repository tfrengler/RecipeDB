<cfcomponent output="false" modifier="final" extends="Model" >

	<cfset variables.UserID = 0 />
	<cfset variables.DateCreated = null />
	<cfset variables.DateTimePreviousLogin = null />
	<cfset variables.DateTimeLastLogin = null />
	<cfset variables.Password = null />
	<cfset variables.PasswordSalt = null />
	<cfset variables.TempPassword = null />
	<cfset variables.UserName = null />
	<cfset variables.DisplayName = null />
	<cfset variables.TimesLoggedIn = 0 />
	<cfset variables.BrowserLastUsed = null />
	<cfset variables.Blocked = false />
	<cfset variables.AuthKey = "" />

	<cfset variables.Settings_FindRecipes_ListType = null />
	<cfset variables.Settings_FindRecipes_SortOnColumn = null />
	<cfset variables.Settings_FindRecipesFilterOn_MineOnly = false />
	<cfset variables.Settings_FindRecipesFilterOn_MinePublic = false />
	<cfset variables.Settings_FindRecipesFilterOn_MinePrivate = false />
	<cfset variables.Settings_FindRecipesFilterOn_MineEmpty = false />
	<cfset variables.Settings_FindRecipesFilterOn_MineNoPicture = false />
	<cfset variables.Settings_FindRecipesFilterOn_OtherUsersOnly = false />

	<cfscript>
		static {
			static.TableName = "Users";
			static.TableKey = "UserID";
			static.TableColumns = "TempPassword,PasswordSalt,BrowserLastUsed,DisplayName,Blocked,DateTimeLastLogin,DateCreated,TimesLoggedIn,Password,UserName";
		};
	</cfscript>

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

	<cffunction name="getSettings" access="public" returntype="struct" output="false" hint="" >
		<cfreturn {
			findRecipes: {
				listType: variables.Settings_FindRecipes_ListType,
				sortOnColumn: variables.Settings_FindRecipes_SortOnColumn,
				filter: {
					mineOnly: variables.Settings_FindRecipesFilterOn_MineOnly,
					minePublic: variables.Settings_FindRecipesFilterOn_MinePublic,
					minePrivate: variables.Settings_FindRecipesFilterOn_MinePrivate,
					mineEmpty: variables.Settings_FindRecipesFilterOn_MineEmpty,
					mineNoPicture: variables.Settings_FindRecipesFilterOn_MineNoPicture,
					otherUsersOnly: variables.Settings_FindRecipesFilterOn_OtherUsersOnly
				}
			}
		} />
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

	<!--- Settings setters --->

	<cffunction name="setFindRecipes_ListType" access="public" output="false" hint="" >
		<cfargument name="data" type="string" required="true" hint="" />

		<cfif listFind("full,simple", arguments.data) IS 0 >
			<cfthrow message="Error changing setting" detail="Argument data is not valid, it must be 'simple' or 'full': #arguments.data#" />
		</cfif>

		<cfset variables.Settings_FindRecipes_ListType = arguments.data />
	</cffunction>

	<cffunction name="setFindRecipes_SortOnColumn" access="public" output="false" hint="" >
		<cfargument name="data" type="string" required="true" hint="" />

		<cfset var AllowedColumns = "Name,CreatedBy,CreatedOn,ModifiedOn,Published,ID" />

		<cfif listFind(AllowedColumns, arguments.data) IS 0 >
			<cfthrow message="Error changing setting" detail="Argument data is not valid, it must be '#AllowedColumns#' : #arguments.data#" />
		</cfif>

		<cfset variables.Settings_FindRecipes_SortOnColumn = arguments.data />
	</cffunction>

	<cffunction name="setFindRecipesFilterOn_MineOnly" access="public" output="false" hint="" >
		<cfargument name="data" type="boolean" required="true" hint="" />

		<cfset variables.Settings_FindRecipesFilterOn_MineOnly = arguments.data />
	</cffunction>

	<cffunction name="setFindRecipesFilterOn_MinePublic" access="public" output="false" hint="" >
		<cfargument name="data" type="boolean" required="true" hint="" />

		<cfset variables.Settings_FindRecipesFilterOn_MinePublic = arguments.data />
	</cffunction>

	<cffunction name="setFindRecipesFilterOn_MinePrivate" access="public" output="false" hint="" >
		<cfargument name="data" type="boolean" required="true" hint="" />

		<cfset variables.Settings_FindRecipesFilterOn_MinePrivate = arguments.data />
	</cffunction>

	<cffunction name="setFindRecipesFilterOn_MineEmpty" access="public" output="false" hint="" >
		<cfargument name="data" type="boolean" required="true" hint="" />

		<cfset variables.Settings_FindRecipesFilterOn_MineEmpty = arguments.data />
	</cffunction>

	<cffunction name="setFindRecipesFilterOn_MineNoPicture" access="public" output="false" hint="" >
		<cfargument name="data" type="boolean" required="true" hint="" />

		<cfset variables.Settings_FindRecipesFilterOn_MineNoPicture = arguments.data />
	</cffunction>

	<cffunction name="setFindRecipesFilterOn_OtherUsersOnly" access="public" output="false" hint="" >
		<cfargument name="data" type="boolean" required="true" hint="" />

		<cfset variables.Settings_FindRecipesFilterOn_OtherUsersOnly = arguments.data />
	</cffunction>

	<!--- Methods --->

	<cffunction name="changePassword" returntype="void" access="public" output="false" hint="" >
		<cfargument name="SecurityManager" type="Components.SecurityManager" required="true" hint="A reference to an instance of the SecurityManager object" />
		<cfargument name="Password" type="string" required="false" default="" hint="The new password, in plain text (non-hashed)" />
		<cfargument name="TempPassword" type="boolean" required="false" default="false" hint="Whether this is a temporary password or not" />

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

			<cfset variables.setPassword( Password=NewFinalPassword ) />
			<cfset variables.setPasswordSalt( Salt=NewPasswordSalt ) />

		<cfelse>
			<cfset variables.setTempPassword( Password=NewPassword ) />
		</cfif>
	</cffunction>

	<cffunction name="validatePassword" returntype="boolean" access="public" output="false" hint="Checks the password you pass against the user's password" >
		<cfargument name="SecurityManager" type="Components.SecurityManager" required="true" hint="A reference to an instance of the SecurityManager object" />
		<cfargument name="Password" type="string" required="true" default="" hint="The password to validate, unhashed" />

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

		<cfset var CurrentLoginCount = getTimesLoggedIn() />
		<cfset variables.setTimesLoggedIn( Count=CurrentLoginCount+1 ) />

		<cfset variables.setDateTimePreviousLogin( Date=getDateTimeLastLogin() ) />

		<cfset variables.setDateTimeLastLogin( Time=createODBCDateTime(now()) ) />
		<cfset variables.setBrowserLastUsed( UserAgentString=arguments.UserAgentString ) />
	</cffunction>

	<cffunction name="saveSettings" returntype="void" access="public" output="false" hint="" >

		<cfset var SaveSettings = null />
		<cfset var Settings = variables.getSettings() />

		<cftransaction action="begin" >
			<cftry>
				<cfquery name="SaveSettings" >
					UPDATE UserSettings
					SET
						FindRecipes_ListType = <cfqueryparam sqltype="LONGVARCHAR" value=#Settings.findRecipes.listType# />,
						FindRecipes_SortOnColumn = <cfqueryparam sqltype="LONGVARCHAR" value=#Settings.findRecipes.sortOnColumn# />,
						FindRecipesFilterOn_MineOnly = <cfqueryparam sqltype="BOOLEAN" value=#Settings.findRecipes.filter.mineOnly# />,
						FindRecipesFilterOn_MinePublic = <cfqueryparam sqltype="BOOLEAN" value=#Settings.findRecipes.filter.minePublic# />,
						FindRecipesFilterOn_MinePrivate = <cfqueryparam sqltype="BOOLEAN" value=#Settings.findRecipes.filter.minePrivate# />,
						FindRecipesFilterOn_MineEmpty = <cfqueryparam sqltype="BOOLEAN" value=#Settings.findRecipes.filter.mineEmpty# />,
						FindRecipesFilterOn_MineNoPicture = <cfqueryparam sqltype="BOOLEAN" value=#Settings.findRecipes.filter.mineNoPicture# />,
						FindRecipesFilterOn_OtherUsersOnly = <cfqueryparam sqltype="BOOLEAN" value=#Settings.findRecipes.filter.otherUsersOnly# />
					WHERE BelongsToUser = <cfqueryparam sqltype="BIGINT" value=#getID()# />;
				</cfquery>

				<cftransaction action="commit" />
			<cfcatch>

				<cftransaction action="rollback" />
				<cfthrow object="#cfcatch#" />

			</cfcatch>
			</cftry>
		</cftransaction>
	</cffunction>

	<cffunction name="loadSettings" returntype="void" access="public" output="false" hint="" >
		<cfset var UserSettingsQuery = queryNew("") />

		<cfquery name="UserSettingsQuery" >
			SELECT
				FindRecipes_ListType,
				FindRecipes_SortOnColumn,
				FindRecipesFilterOn_MineOnly,
				FindRecipesFilterOn_MinePublic,
				FindRecipesFilterOn_MinePrivate,
				FindRecipesFilterOn_MineEmpty,
				FindRecipesFilterOn_MineNoPicture,
				FindRecipesFilterOn_OtherUsersOnly
			FROM UserSettings
			WHERE BelongsToUser = <cfqueryparam sqltype="BIGINT" value="#getID()#" />
		</cfquery>

		<cfif UserSettingsQuery.RecordCount GT 0 >

			<cfset variables.setFindRecipes_ListType(data=UserSettingsQuery.FindRecipes_ListType) />
			<cfset variables.setFindRecipes_SortOnColumn(data=UserSettingsQuery.FindRecipes_SortOnColumn) />
			<cfset variables.setFindRecipesFilterOn_MineOnly(data=UserSettingsQuery.FindRecipesFilterOn_MineOnly) />
			<cfset variables.setFindRecipesFilterOn_MinePublic(data=UserSettingsQuery.FindRecipesFilterOn_MinePublic) />
			<cfset variables.setFindRecipesFilterOn_MinePrivate(data=UserSettingsQuery.FindRecipesFilterOn_MinePrivate) />
			<cfset variables.setFindRecipesFilterOn_MineEmpty(data=UserSettingsQuery.FindRecipesFilterOn_MineEmpty) />
			<cfset variables.setFindRecipesFilterOn_MineNoPicture(data=UserSettingsQuery.FindRecipesFilterOn_MineNoPicture) />
			<cfset variables.setFindRecipesFilterOn_OtherUsersOnly(data=UserSettingsQuery.FindRecipesFilterOn_OtherUsersOnly) />

		<cfelse>
			<cfthrow message="Error when loading user settings data. There appears to be no settings for this UserID: #getID()#" />
		</cfif>
	</cffunction>

	<cffunction name="save" returntype="void" access="public" output="false" hint="Persists the current state of the user to the db" >
		<cfset var UpdateUser = null />

		<cftransaction action="begin" >
			<cftry>
				<cfquery name="UpdateUser" >
					UPDATE #static.TableName#
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

					WHERE #static.TableKey# = <cfqueryparam sqltype="INT" value="#getID()#" />;
				</cfquery>

				<cftransaction action="commit" />
			<cfcatch>

				<cftransaction action="rollback" />
				<cfthrow object="#cfcatch#" />

			</cfcatch>
			</cftry>
		</cftransaction>
	</cffunction>

	<cffunction modifier="static" name="create" returntype="Models.User" access="public" hint="Static method. Creates a new empty user in the db and returns an instance of this user" output="true" >
		<cfargument name="username" type="string" required="true" hint="The login name for the new user." />

		<cfif len(arguments.username) IS 0 >
			<cfthrow message="Error creating new user" detail="The username you passed is empty, this is not allowed." />
		</cfif>

		<cfset var NewUserID = null />

		<cftransaction action="begin" >
			<cftry>

				<cfset queryExecute(
					"INSERT INTO '#static.TableName#' (
						DateCreated,
						UserName,
						DisplayName,
						DateTimeLastLogin
					)
					VALUES(?,?,?,?)",
					[
						Components.Localizer::getDBDate(now()),
						arguments.Username,
						"New user XYZ#randRange(1, 100)#",
						Components.Localizer::getDBDateTime(now())
					],
					{result="NewUserID"}
				) />

				<cfset queryExecute(
					"INSERT INTO 'UserSettings' (
						BelongsToUser,
						FindRecipes_ListType,
						FindRecipes_SortOnColumn
					)
					VALUES(?,?,?)",
					[
						NewUserID.generatedKey,
						'full',
						'CreatedOn'
					]
				) />

				<cftransaction action="commit" />
			<cfcatch>

				<cftransaction action="rollback" />
				<cfthrow object="#cfcatch#" />

			</cfcatch>
			</cftry>
		</cftransaction>

		<cfreturn new User(ID=NewUserID.generatedKey) />
	</cffunction>

	<cffunction name="load" returntype="void" access="private" output="false" hint="Fills the instance with data from the db." >

		<cfset var UserData = queryNew("") />

		<cfquery name="UserData" >
			SELECT #static.TableColumns#
			FROM #static.TableName#
			WHERE #static.TableKey# = <cfqueryparam sqltype="INT" value="#getID()#" />
		</cfquery>

		<cfif UserData.RecordCount GT 0 >
			<cfset variables.setDateCreated( Components.Localizer::getBackendDate(UserData.DateCreated) ) />
			<cfset variables.setDateTimeLastLogin( Components.Localizer::getBackendDateTime(UserData.DateTimeLastLogin) ) />
			<cfset variables.setPassword( Password=UserData.Password ) />
			<cfset variables.setPasswordSalt( Salt=UserData.PasswordSalt ) />
			<cfset variables.setTempPassword( Password=UserData.TempPassword ) />
			<cfset variables.setUserName( Name=UserData.UserName ) />
			<cfset variables.setDisplayName( Name=UserData.DisplayName ) />
			<cfset variables.setTimesLoggedIn( Count=UserData.TimesLoggedIn ) />
			<cfset variables.setBrowserLastUsed( UserAgentString=UserData.BrowserLastUsed ) />
			<cfset variables.setBlocked( Blocked=UserData.Blocked ) />
		<cfelse>
			<cfthrow message="Error when loading user data. There appears to be no userdata with this #static.TableKey#: #getID()#" />
		</cfif>
	</cffunction>

	<cffunction name="init" access="public" returntype="Models.User" output="false" hint="Constructor, returns an initialized user who is by default blocked." >
		<cfargument name="ID" type="numeric" required="true" hint="The UserID of the user you want to init this instance with." />

		<cfset variables.setID( Value=arguments.ID ) >
		<cfset variables.load() />
		<cfset variables.loadSettings() />

		<cfset variables.IsStatic = false />

		<cfreturn this />
	</cffunction>

</cfcomponent>