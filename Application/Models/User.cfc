<cfcomponent output="false" modifier="final" persistent="true" extends="Model" >

	<cfproperty name="UserID" 					type="numeric"		getter="true"	setter="true" />
	<cfproperty name="DateCreated" 				type="date"			getter="true"	setter="true" />
	<cfproperty name="DateTimePreviousLogin" 	type="date"			getter="true"	setter="true" />
	<cfproperty name="DateTimeLastLogin" 		type="date"			getter="true"	setter="true" />
	<cfproperty name="Password" 				type="string"		getter="true"	setter="true" />
	<cfproperty name="PasswordSalt" 			type="string"		getter="true"	setter="true" />
	<cfproperty name="TempPassword" 			type="string"		getter="true"	setter="true" />
	<cfproperty name="UserName" 				type="string"		getter="true"	setter="true" />
	<cfproperty name="DisplayName" 				type="string"		getter="true"	setter="true" />
	<cfproperty name="TimesLoggedIn" 			type="numeric"		getter="true"	setter="true" />
	<cfproperty name="BrowserLastUsed" 			type="string"		getter="true"	setter="true" />
	<cfproperty name="Blocked" 					type="boolean"		getter="true"	setter="true" />
	<cfproperty name="AuthKey" 					type="string"		getter="true"	setter="true" />

	<cfproperty name="Settings_FindRecipes_ListType"				type="string" 	getter="false"	setter="false" />
	<cfproperty name="Settings_FindRecipes_SortOnColumn"			type="string" 	getter="false"	setter="false" />
	<cfproperty name="Settings_FindRecipesFilterOn_MineOnly"		type="boolean" 	getter="false"	setter="true" />
	<cfproperty name="Settings_FindRecipesFilterOn_MinePublic"		type="boolean" 	getter="false"	setter="true" />
	<cfproperty name="Settings_FindRecipesFilterOn_MinePrivate"		type="boolean" 	getter="false"	setter="true" />
	<cfproperty name="Settings_FindRecipesFilterOn_MineEmpty"		type="boolean" 	getter="false"	setter="true" />
	<cfproperty name="Settings_FindRecipesFilterOn_MineNoPicture"	type="boolean" 	getter="false"	setter="true" />
	<cfproperty name="Settings_FindRecipesFilterOn_OtherUsersOnly"	type="boolean" 	getter="false"	setter="true" />

	<cfscript>
		static {
			static.TableName = "Users";
			static.TableKey = "UserID";
			static.TableColumns = "TempPassword,PasswordSalt,BrowserLastUsed,DisplayName,Blocked,DateTimeLastLogin,DateCreated,TimesLoggedIn,Password,UserName";
		};
	</cfscript>

	<!--- Settings --->

	<cffunction name="GetSettings" access="public" returntype="struct" output="false" hint="" >
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

	<cffunction name="SetFindRecipes_ListType" returntype="string" access="public" output="false" hint="" >
		<cfargument name="data" type="string" required="true" hint="" />

		<cfif listFind("full,simple", arguments.data) IS 0 >
			<cfthrow message="Error changing setting" detail="Argument data is not valid, it must be 'simple' or 'full': #arguments.data#" />
		</cfif>

		<cfset variables.Settings_FindRecipes_ListType = arguments.data />
	</cffunction>

	<cffunction name="SetFindRecipes_SortOnColumn" returntype="string" access="public" output="false" hint="" >
		<cfargument name="data" type="string" required="true" hint="" />

		<cfset var AllowedColumns = "Name,CreatedBy,CreatedOn,ModifiedOn,Published,ID" />

		<cfif listFind(AllowedColumns, arguments.data) IS 0 >
			<cfthrow message="Error changing setting" detail="Argument data is not valid, it must be '#AllowedColumns#' : #arguments.data#" />
		</cfif>

		<cfset variables.Settings_FindRecipes_SortOnColumn = arguments.data />
	</cffunction>

	<!--- INSTANCE--->
	<!--- Public --->

	<cffunction name="ChangePassword" returntype="void" access="public" output="false" hint="" >
		<cfargument name="securityManager" type="Components.SecurityManager" required="true" hint="A reference to an instance of the SecurityManager object" />
		<cfargument name="password" type="string" required="false" default="" hint="The new password, in plain text (non-hashed)" />
		<cfargument name="tempPassword" type="boolean" required="false" default="false" hint="Whether this is a temporary password or not" />

		<cfset var NewPassword = "" />
		<cfset var NewPasswordSalt = arguments.securityManager.getSaltedString() />

		<cfif len( trim(arguments.password) ) IS 0 >
			<cfset NewPassword = arguments.securityManager.createPassword() />
		<cfelse>
			<cfset NewPassword = arguments.password />
		</cfif>

		<cfif NOT arguments.tempPassword >

			<cfset var NewPasswordHashed = arguments.securityManager.getHashedString(NewPassword) />
			<cfset var NewFinalPassword = arguments.securityManager.getHashedString(NewPasswordHashed & NewPasswordSalt) />

			<cfset variables.Password = NewFinalPassword />
			<cfset variables.PasswordSalt = NewPasswordSalt />

		<cfelse>
			<cfset variables.TempPassword = NewPassword />
		</cfif>
	</cffunction>

	<cffunction name="ValidatePassword" returntype="boolean" access="public" output="false" hint="Checks the password you pass against the user's password" >
		<cfargument name="securityManager" type="Components.SecurityManager" required="true" hint="A reference to an instance of the SecurityManager object" />
		<cfargument name="password" type="string" required="true" default="" hint="The password to validate, unhashed" />

		<cfset var UsersPassword = variables.Password />
		<cfset var UsersPasswordSalt = variables.PasswordSalt />

		<cfset var HashedPassword = arguments.securityManager.getHashedString(arguments.Password) />
		<cfset var HashedAndSaltedPassword = arguments.securityManager.getHashedString(HashedPassword & UsersPasswordSalt) />

		<cfreturn UsersPassword IS HashedAndSaltedPassword />
	</cffunction>

	<cffunction name="UpdateLoginStats" returntype="void" access="public" output="false" hint="Updates the login count and datetime of last login. Should be called whenever the user successfully logs in." >
		<cfargument name="userAgentString" type="string" required="true" hint="The user agent string of the user logging in" />

		<cfset variables.TimesLoggedIn = variables.TimesLoggedIn + 1 />

		<cfset variables.DateTimePreviousLogin = variables.DateTimeLastLogin />
		<cfset variables.DateTimeLastLogin = createODBCDateTime(now()) />

		<cfset variables.BrowserLastUsed = arguments.userAgentString />
	</cffunction>

	<cffunction name="SaveSettings" returntype="void" access="public" output="false" hint="" >

		<cfset var Settings = getSettings() />

		<cftransaction action="begin" >
			<cftry>

				<cfset queryExecute(
					"UPDATE 'UserSettings'
					SET
						FindRecipes_ListType = ?,
						FindRecipes_SortOnColumn = ?,
						FindRecipesFilterOn_MineOnly = ?,
						FindRecipesFilterOn_MinePublic = ?,
						FindRecipesFilterOn_MinePrivate = ?,
						FindRecipesFilterOn_MineEmpty = ?,
						FindRecipesFilterOn_MineNoPicture = ?,
						FindRecipesFilterOn_OtherUsersOnly = ?,

					WHERE BelongsToUser = ?;",
					[
						Settings.findRecipes.listType,
						Settings.findRecipes.sortOnColumn,
						Settings.findRecipes.filter.mineOnly,
						Settings.findRecipes.filter.minePublic,
						Settings.findRecipes.filter.minePrivate,
						Settings.findRecipes.filter.mineEmpty,
						Settings.findRecipes.filter.mineNoPicture,
						Settings.findRecipes.filter.otherUsersOnly,
						variables.UserID
					]
				) />

				<cftransaction action="commit" />
			<cfcatch>

				<cftransaction action="rollback" />
				<cfthrow object="#cfcatch#" />

			</cfcatch>
			</cftry>
		</cftransaction>
	</cffunction>

	<cffunction name="LoadSettings" returntype="void" access="public" output="false" hint="" >

		<cfset var UserSettingsQuery = queryExecute(
			"SELECT
				FindRecipes_ListType,
				FindRecipes_SortOnColumn,
				FindRecipesFilterOn_MineOnly,
				FindRecipesFilterOn_MinePublic,
				FindRecipesFilterOn_MinePrivate,
				FindRecipesFilterOn_MineEmpty,
				FindRecipesFilterOn_MineNoPicture,
				FindRecipesFilterOn_OtherUsersOnly
			FROM UserSettings
			WHERE BelongsToUser = ?;",
			[
				{value=variables.UserID, cfsqltype="integer"}
			]
		) />

		<cfif UserSettingsQuery.RecordCount GT 0 >

			<cfset setFindRecipes_ListType(UserSettingsQuery.FindRecipes_ListType) />
			<cfset setFindRecipes_SortOnColumn(UserSettingsQuery.FindRecipes_SortOnColumn) />
			<cfset setSettings_FindRecipesFilterOn_MineOnly(UserSettingsQuery.FindRecipesFilterOn_MineOnly) />
			<cfset setSettings_FindRecipesFilterOn_MinePublic(UserSettingsQuery.FindRecipesFilterOn_MinePublic) />
			<cfset setSettings_FindRecipesFilterOn_MinePrivate(UserSettingsQuery.FindRecipesFilterOn_MinePrivate) />
			<cfset setSettings_FindRecipesFilterOn_MineEmpty(UserSettingsQuery.FindRecipesFilterOn_MineEmpty) />
			<cfset setSettings_FindRecipesFilterOn_MineNoPicture(UserSettingsQuery.FindRecipesFilterOn_MineNoPicture) />
			<cfset setSettings_FindRecipesFilterOn_OtherUsersOnly(UserSettingsQuery.FindRecipesFilterOn_OtherUsersOnly) />

		<cfelse>
			<cfthrow message="Error when loading user settings data. There appears to be no settings for this UserID: #variables.UserID#" />
		</cfif>
	</cffunction>

	<cffunction name="Save" returntype="void" access="public" output="false" hint="Persists the current state of the user to the db" >

		<cftransaction action="begin" >
			<cftry>

				<cfset queryExecute(
					"UPDATE #static.TableName#
					SET
						Password = ?,
						PasswordSalt = ?,
						TempPassword = ?,
						UserName = ?,
						DisplayName = ?,
						TimesLoggedIn = ?,
						BrowserLastUsed = ?,
						Blocked = ?,
						DateTimeLastLogin = ?

					WHERE #static.TableKey# = ?;",
					[
						variables.Password,
						variables.PasswordSalt,
						variables.TempPassword,
						variables.UserName,
						variables.DisplayName,
						variables.TimesLoggedIn,
						variables.BrowserLastUsed,
						variables.Blocked,
						Components.Localizer::GetDBDateTime(variables.DateTimeLastLogin),
						variables.UserID
					]
				) />

				<cftransaction action="commit" />
			<cfcatch>

				<cftransaction action="rollback" />
				<cfthrow object="#cfcatch#" />

			</cfcatch>
			</cftry>
		</cftransaction>
	</cffunction>

	<!--- Private --->

	<cffunction name="Load" returntype="void" access="private" output="false" hint="Fills the instance with data from the db." >

		<cfset var UserData = queryExecute(
			"SELECT #static.TableColumns#
			FROM #static.TableName#
			WHERE #static.TableKey# = ?;",
			[
				{value=variables.UserID, cfsqltype="integer"}
			]
		) />

		<cfif UserData.RecordCount GT 0 >

			<cfset var DateCreated = Components.Localizer::GetBackendDate(UserData.DateCreated) />
			<cfset var DateTimeLastLogin = Components.Localizer::GetBackendDateTime(UserData.DateTimeLastLogin) />

			<cfset variables.DateCreated = DateCreated />
			<cfset variables.DateTimeLastLogin = DateTimeLastLogin />
			<cfset variables.Password = UserData.Password />
			<cfset variables.PasswordSalt = UserData.PasswordSalt />
			<cfset variables.TempPassword = UserData.TempPassword />
			<cfset variables.UserName = UserData.UserName />
			<cfset variables.DisplayName = UserData.DisplayName />
			<cfset variables.TimesLoggedIn = UserData.TimesLoggedIn />
			<cfset variables.BrowserLastUsed = UserData.BrowserLastUsed />
			<cfset variables.Blocked = UserData.Blocked />
		<cfelse>
			<cfthrow message="Error when loading user data. There appears to be no userdata with this #static.TableKey#: #variables.UserID#" />
		</cfif>
	</cffunction>

	<!--- STATIC --->
	<!--- Public --->

	<cffunction modifier="static" name="Create" returntype="Models.User" access="public" hint="Static method. Creates a new empty user in the db and returns an instance of this user" output="true" >
		<cfargument name="username" type="string" required="true" hint="The login name for the new user." />

		<cfif len(arguments.username) IS 0 >
			<cfthrow message="Error creating new user" detail="The username you passed is empty, this is not allowed." />
		</cfif>

		<cfset var NewUser = null />

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
						Components.Localizer::GetDBDate(now()),
						arguments.Username,
						"New user XYZ#randRange(1, 100)#",
						Components.Localizer::GetDBDateTime(now())
					],
					{result="NewUser"}
				) />

				<cfset queryExecute(
					"INSERT INTO 'UserSettings' (
						BelongsToUser,
						FindRecipes_ListType,
						FindRecipes_SortOnColumn
					)
					VALUES(?,?,?)",
					[
						NewUser.generatedKey,
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

		<cfreturn new User(NewUser.generatedKey) />
	</cffunction>

	<!--- Constructor --->

	<cffunction name="init" access="public" returntype="Models.User" output="false" hint="Constructor, returns an initialized user who is by default blocked." >
		<cfargument name="ID" type="numeric" required="true" hint="The UserID of the user you want to init this instance with." />

		<cfset variables.UserID = arguments.ID >
		<cfset Load() />
		<cfset LoadSettings() />

		<cfreturn this />
	</cffunction>

</cfcomponent>