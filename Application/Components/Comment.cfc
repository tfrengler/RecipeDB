<cfcomponent output="false" extends="Model" >
<cfprocessingdirective pageEncoding="utf-8"  />

	<cfset CommentID = 0 />
	<cfset RecipeID = 0 />
	<cfset CommentText = "" />
	<cfset CreatedByUser = "" />
	<cfset DateTimeCreated = createDateTime(666, 6, 6, 0, 0) />

	<cfset TableName = "Comments" />
	<cfset TableKey = "CommentID" />
	<cfset TableColumns = "RecipeID,CommentText,UserID,DateTimeCreated" />

	<!--- Getters --->

	<cffunction name="getCommentID" returntype="numeric" access="public" output="false" hint="" >
		<cfreturn CommentID />
	</cffunction>

	<cffunction name="getRecipeID" returntype="numeric" access="public" output="false" hint="" >
		<cfreturn RecipeID />
	</cffunction>

	<cffunction name="getCommentText" returntype="string" access="public" output="false" hint="" >
		<cfreturn CommentText />
	</cffunction>

	<cffunction name="getCreatedByUser" returntype="Models.User" access="public" output="false" hint="" >
		<cfreturn CreatedByUser />
	</cffunction>

	<cffunction name="getDateTimeCreated" returntype="date" access="public" output="false" hint="" >
		<cfreturn DateTimeCreated />
	</cffunction>

	<cffunction name="getTableName" returntype="string" access="public" output="false" hint="" >
		<cfreturn "Comments" />
	</cffunction>

	<cffunction name="getTableKey" returntype="string" access="public" output="false" hint="" >
		<cfreturn "CommentID" />
	</cffunction>

	<!--- Setters --->

	<cffunction name="setCommentID" returntype="void" access="private" output="false" hint="" >
		<cfargument name="ID" type="numeric" required="true" hint="" />

		<cfset CommentID = arguments.ID />
	</cffunction>

	<cffunction name="setRecipeID" returntype="void" access="private" output="false" hint="" >
		<cfargument name="ID" type="numeric" required="true" hint="" />

		<cfset RecipeID = arguments.ID />
	</cffunction>

	<cffunction name="setCommentText" returntype="void" access="public" output="false" hint="" >
		<cfargument name="Data" type="string" required="true" hint="" />

		<cfset CommentText = arguments.Data />
	</cffunction>

	<cffunction name="setCreatedByUser" returntype="void" access="private" output="false" hint="" >
		<cfargument name="UserInstance" type="Models.User" required="true" hint="" />

		<cfset CreatedByUser = arguments.ID />
	</cffunction>

	<cffunction name="setDateTimeCreated" returntype="void" access="private" output="false" hint="" >
		<cfargument name="Date" type="date" required="true" hint="" />

		<cfset DateCreated = arguments.Date />
	</cffunction>

	<!--- Methods --->

	<cffunction name="exists" returntype="boolean" access="private" output="false" hint="" >
		<cfargument name="ID" type="numeric" required="true" hint="" />

		<cfset onInitialized() />

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

		<cfset onStatic() />

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

		<cfset onInitialized() />

		<cfset var CreateComment = queryNew("") />

		<cfset setRecipeID( ID=arguments.RecipeID ) />
		<cfset setUserID( ID=arguments.UserID ) />
		<cfset setDateTimeCreated( Date=createODBCTime(now()) ) />

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
		<cfset var CommentCreator = "" />

		<cfquery name="CommentData" datasource="#getDatasource()#" >
			SELECT #getTableColumns()#
			FROM #getTableName()#
			WHERE #getTableKey()# = <cfqueryparam sqltype="BIGINT" value="#getCommentID()#" />
		</cfquery>

		<cfif CommentData.RecordCount GT 0 >
			<cfset setRecipeID( ID=CommentData.RecipeID ) />
			<cfset setCommentText( Data=CommentText ) />
			<cfset setDateTimeCreated( Date=DateTimeCreated ) />

		<cfelse>
			<cfthrow message="Error when loading recipe data" detail="There appears to be no recipe with this #getTableKey()#: #getCommentID()#" />
			<cfreturn false />
		</cfif>

		<cfset CommentCreator = createObject("component", "Models.User").init( 
			ID=CommentData.CreatedByUser,
			Datasource=getDatasource()
		) />

		<cfset setCreatedByUser( UserInstance=UserID ) />

		<cfreturn true />
	</cffunction>

	<cffunction name="getData" returntype="query" access="public" output="false" hint="Static method. Fetch data from a specific comment or multiple comments." >
		<cfargument name="ColumnList" type="string" required="false" default="" hint="List of columns you want to fetch data from." />
		<cfargument name="ID" type="numeric" required="false" default="0" hint="ID of the comment you want to fetch data for. If you leave this out you get all recipes." />
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
 
	<cffunction name="init" access="public" returntype="Components.Comment" output="false" hint="Constructor, returns an initialized comment." >
		<cfargument name="ID" type="numeric" required="true" hint="" />
		<cfargument name="Datasource" type="string" required="true" hint="The name of the datasource to use for queries." />

		<cfif len(arguments.Datasource) IS 0 >
			<cfthrow message="Error when initializing comment" detail="The 'Datasource' argument appears to be empty" />
		</cfif>

		<cfset variables.setDataSource( Name= trim(arguments.Datasource) ) />

		<cfif exists( ID=arguments.ID ) IS false >
			<cfthrow message="Error when initializing comment" detail="No comment with this #getTableKey()# exists: #arguments.ID#" />
		</cfif>

		<cfset setCommentID( ID=arguments.ID ) >

		<cfset load() />

		<cfreturn this />
	</cffunction>

</cfcomponent>