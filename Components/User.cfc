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

	<!--- Getters --->

	<cffunction name="getUserID" access="public" output="false" hint="" >
			<cfreturn UserID />
	</cffunction>

	<cffunction name="getSessionID" access="public" output="false" hint="" >
			<cfreturn SessionID />
	</cffunction>

	<cffunction name="getDateCreated" access="public" output="false" hint="" >
			<cfreturn DateCreated />
	</cffunction>

	<cffunction name="getDateTimeLastLogin" access="public" output="false" hint="" >
			<cfreturn DateTimeLastLogin />
	</cffunction>

	<cffunction name="getPassword" access="public" output="false" hint="" >
			<cfreturn Password />
	</cffunction>

	<cffunction name="getTempPassword" access="public" output="false" hint="" >
			<cfreturn TempPassword />
	</cffunction>

	<cffunction name="getUserName" access="public" output="false" hint="" >
			<cfreturn UserName />
	</cffunction>

	<cffunction name="getDisplayName" access="public" output="false" hint="" >
			<cfreturn DisplayName />
	</cffunction>

	<cffunction name="getTimesLoggedIn" access="public" output="false" hint="" >
			<cfreturn TimesLoggedIn />
	</cffunction>

	<cffunction name="getBrowserLastUsed" access="public" output="false" hint="" >
			<cfreturn BrowserLastUsed />
	</cffunction>

	<cffunction name="getBlocked" access="public" output="false" hint="" >
			<cfreturn Blocked />
	</cffunction>

	<cffunction name="getTableName" access="public" output="false" hint="" >
		<cfreturn "Users" />
	</cffunction> 

	<cffunction name="getTableKey" access="public" output="false" hint="" >
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

	<cffunction name="doesUserExist" returntype="boolean" access="private" output="false" hint="" >
		<cfargument name="ID" type="numeric" required="true" hint="" />

		<cfset var UserExistenceCheck = queryNew("") />
		<cfquery name="UserExistenceCheck" datasource="test" >
			SELECT #getTableKey()#
			FROM #getTableName()#
			WHERE #getTableKey# = <cfqueryparam sqltype="CF_SQL_BIGINT" value="#arguments.ID#" />
		</cfquery>

		<cfif UserExistenceCheck.RecordCount IS 1 >
			<cfreturn true />
		</cfif>

		<cfreturn false />
	</cffunction>

	<cffunction name="save" returntype="boolean" access="public" output="false" hint="Persists the current state of the user to the db" >

		<cfif doesUserExist( ID=getUserID() ) IS false >
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

	<cffunction name="createNew" returntype="numeric" access="public" hint="Creates a new empty comment in the db, related to a recipe, and returns the ID of the new record" >
		<cfargument name="UserID" required="true" type="numeric" />
		<cfargument name="RecipeID" required="true" type="numeric" />

		<cfset var CreateComment = queryNew("") />

		<cfset RecipeID( ID=arguments.RecipeID ) />
		<cfset UserID( ID=arguments.UserID ) />
		<cfset DateTimeCreated( Date=createODBCTime(now()) ) />

		<cfif getCommentID() GT 0 >
			<cfthrow message="You can't call create() on an initialized comment: #getCommentID()#" />
		</cfif>

		<cftransaction action="begin" >
			<cftry>
				<cfquery name="CreateComment" datasource="test" >
					INSERT INTO #getTableName()# (
						RecipeID,
						CommentText,
						UserID,
						DateTimeCreated
					)
					VALUES (
						<cfqueryparam sqltype="BIGINT" value="#getRecipeID()#" />,
						<cfqueryparam sqltype="LONGVARCHAR" value="#getCommentText()#" />,
						<cfqueryparam sqltype="BIGINT" value="#getUserID()#" />,
						<cfqueryparam sqltype="TIMESTAMP" value="#getDateTimeCreated()#" />,
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

		<cfset setCommentID( Data=CreateComment.RecipeID ) />
		<cfreturn CreateComment.RecipeID />
	</cffunction>

	<cffunction name="load" returntype="boolean" access="private" output="false" hint="Fills this objects instance with data from the db" >

		<cfset var CommentData = queryNew("") />

		<cfquery name="CommentData" datasource="test" >
			SELECT *
			FROM #getTableName()#
			WHERE #getTableKey()# = <cfqueryparam sqltype="BIGINT" value="#getCommentID()#" />
		</cfquery>

		<cfif GetRecipeData.RecordCount GT 0 >
			<cfset setCommentID( ID=CommentData.CommentID ) />
			<cfset setRecipeID( ID=CommentData.RecipeID ) />
			<cfset setCommentText( Data=CommentText ) />
			<cfset setUserID( ID=CommentData.UserID ) />
			<cfset setDateTimeCreated( Date=DateTimeCreated ) />

		<cfelse>
			<cfthrow message="Error when loading recipe data. There appears to be no recipe with this #getTableKey()#: #getCommentID()#" />
			<cfreturn false />
		</cfif>

		<cfreturn true />
	</cffunction>

	<cffunction name="init" access="public" returntype="Components.Comment" output="false" hint="Constructor, returns an initialized comment." >
		<cfargument name="ID" type="numeric" required="true" hint="" />

		<cfif doesCommentExist( ID=arguments.ID ) IS false >
			<cfthrow message="Error when initializing comment. No comment with this #getTableKey()# exists: #arguments.ID#" />
		</cfif>

		<cfset setCommentID( ID=arguments.ID ) >
		<cfset load() />

		<cfreturn this />
	</cffunction>

</cfcomponent>