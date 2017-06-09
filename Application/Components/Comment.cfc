<cfcomponent output="false" extends="Model" >
<cfprocessingdirective pageEncoding="utf-8"  />

	<cfset CommentID = 0 />
	<cfset RecipeID = 0 />
	<cfset CommentText = "" />
	<cfset UserID = 0 />
	<cfset DateTimeCreated = createDateTime(666, 6, 6, 0, 0) />

	<cfset TableName = "Comments" />
	<cfset TableKey = "CommentID" />
	<cfset TableColumns = "RecipeID,CommentText,UserID,DateTimeCreated" />

	<!--- Getters --->

	<cffunction name="getCommentID" access="public" output="false" hint="" >
			<cfreturn CommentID />
	</cffunction>

	<cffunction name="getRecipeID" access="public" output="false" hint="" >
			<cfreturn RecipeID />
	</cffunction>

	<cffunction name="getCommentText" access="public" output="false" hint="" >
			<cfreturn CommentText />
	</cffunction>

	<cffunction name="getUserID" access="public" output="false" hint="" >
			<cfreturn UserID />
	</cffunction>

	<cffunction name="getDateTimeCreated" access="public" output="false" hint="" >
			<cfreturn DateTimeCreated />
	</cffunction>

	<cffunction name="getTableName" access="public" output="false" hint="" >
			<cfreturn "Comments" />
	</cffunction>

	<cffunction name="getTableKey" access="public" output="false" hint="" >
			<cfreturn "CommentID" />
	</cffunction>

	<!--- Setters --->

	<cffunction name="setCommentID" access="private" output="false" hint="" >
		<cfargument name="ID" type="numeric" required="true" hint="" />

		<cfset CommentID = arguments.ID />
	</cffunction>

	<cffunction name="setRecipeID" access="private" output="false" hint="" >
		<cfargument name="ID" type="numeric" required="true" hint="" />

		<cfset RecipeID = arguments.ID />
	</cffunction>

	<cffunction name="setCommentText" access="public" output="false" hint="" >
		<cfargument name="Data" type="string" required="true" hint="" />

		<cfset CommentText = arguments.Data />
	</cffunction>

	<cffunction name="setUserID" access="private" output="false" hint="" >
		<cfargument name="ID" type="numeric" required="true" hint="" />

		<cfset UserID = arguments.ID />
	</cffunction>

	<cffunction name="setDateTimeCreated" access="private" output="false" hint="" >
		<cfargument name="Date" type="date" required="true" hint="" />

		<cfset DateCreated = arguments.Date />
	</cffunction>

	<!--- Methods --->

	<cffunction name="doesCommentExist" returntype="boolean" access="private" output="false" hint="" >
		<cfargument name="ID" type="numeric" required="true" hint="" />

		<cfset var CommentExistenceCheck = queryNew("") />
		<cfquery name="CommentExistenceCheck" datasource="#getDatasource()#" >
			SELECT #getTableKey()#
			FROM #getTableName()#
			WHERE #getTableKey# = <cfqueryparam sqltype="CF_SQL_BIGINT" value="#arguments.ID#" />
		</cfquery>

		<cfif CommentExistenceCheck.RecordCount IS 1 >
			<cfreturn true />
		</cfif>

		<cfreturn false />
	</cffunction>

	<cffunction name="save" returntype="boolean" access="public" output="false" hint="Persists the current state of the comment to the db" >

		<cfif doesCommentExist( ID=getCommentID() ) IS false >
			<cfthrow message="You can't update a comment that doesn't exist: #getCommentID()#" />
			<cfreturn false />
		</cfif>

		<cfset var UpdateComment = queryNew("") />
		
		<cftransaction action="begin" >
			<cftry>
				<cfquery name="UpdateComment" datasource="#getDatasource()#" >
					UPDATE #getTableName()#
					SET	
						RecipeID = <cfqueryparam sqltype="BIGINT" value="#getRecipeID()#" />,
						CommentText = <cfqueryparam sqltype="LONGVARCHAR" value="#getCommentText()#" />,
						UserID = <cfqueryparam sqltype="BIGINT" value="#getUserID()#" />,
						DateCreated = <cfqueryparam sqltype="TIMESTAMP" value="#getDateCreated()#" />

					WHERE #getTableKey()# = <cfqueryparam sqltype="BIGINT" value="#getCommentID()#" />;
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
				<cfquery name="CreateComment" datasource="#getDatasource()#" >
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

		<cfquery name="CommentData" datasource="#getDatasource()#" >
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

	<cffunction name="getData" returntype="query" access="public" output="false" hint="" >
		<cfargument name="ID" type="numeric" required="true" hint="" />
		<cfargument name="ColumnList" type="string" required="true" hint="" />

		<cfif getCommentID() GT 0 >
			<cfthrow message="You can't call getData() on an initialized recipe: #getCommentID()#" />
		</cfif>

		<cfset var CommentData = queryNew() />
		<cfquery name="CommentData" datasource="#getDatasource()#" >
			SELECT #arguments.ColumnList#
			FROM #getTableName()#
			WHERE #getTableKey()# = #arguments.ID#
		</cfquery>

		<cfreturn CommentData />
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