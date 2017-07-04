<cfcomponent output="false" extends="Model" >
<cfprocessingdirective pageEncoding="utf-8"  />

	<cfset CommentID = 0 />
	<cfset RecipeID = 0 />
	<cfset CommentText = "" />
	<cfset CreatedByUser = "" />
	<cfset DateTimeCreated = createDateTime(1666, 6, 6, 0, 0) />

	<cfset TableName = "Comments" />
	<cfset TableKey = "CommentID" />
	<cfset TableColumns = "RecipeID,CommentText,UserID,DateTimeCreated" />

	<!--- Getters --->

	<cffunction name="getID" returntype="numeric" access="public" output="false" hint="" >
		<cfreturn variables.CommentID />
	</cffunction>

	<cffunction name="getRecipeID" returntype="numeric" access="public" output="false" hint="" >
		<cfreturn variables.RecipeID />
	</cffunction>

	<cffunction name="getCommentText" returntype="string" access="public" output="false" hint="" >
		<cfreturn variables.CommentText />
	</cffunction>

	<cffunction name="getCreatedByUser" returntype="Models.User" access="public" output="false" hint="" >
		<cfreturn variables.CreatedByUser />
	</cffunction>

	<cffunction name="getDateTimeCreated" returntype="date" access="public" output="false" hint="" >
		<cfreturn variables.DateTimeCreated />
	</cffunction>

	<cffunction name="getTableName" returntype="string" access="public" output="false" hint="" >
		<cfreturn "Comments" />
	</cffunction>

	<cffunction name="getTableKey" returntype="string" access="public" output="false" hint="" >
		<cfreturn "CommentID" />
	</cffunction>

	<!--- Setters --->

	<cffunction name="setID" returntype="void" access="private" output="false" hint="" >
		<cfargument name="Value" type="numeric" required="true" hint="" />

		<cfset variables.CommentID = arguments.Value />
	</cffunction>

	<cffunction name="setRecipeID" returntype="void" access="private" output="false" hint="" >
		<cfargument name="ID" type="numeric" required="true" hint="" />

		<cfset variables.RecipeID = arguments.ID />
	</cffunction>

	<cffunction name="setCommentText" returntype="void" access="public" output="false" hint="" >
		<cfargument name="Data" type="string" required="true" hint="" />

		<cfset variables.CommentText = arguments.Data />
	</cffunction>

	<cffunction name="setCreatedByUser" returntype="void" access="private" output="false" hint="" >
		<cfargument name="UserInstance" type="Models.User" required="true" hint="" />

		<cfset variables.CreatedByUser = arguments.ID />
	</cffunction>

	<cffunction name="setDateTimeCreated" returntype="void" access="private" output="false" hint="" >
		<cfargument name="Date" type="date" required="true" hint="" />

		<cfset variables.DateCreated = arguments.Date />
	</cffunction>

	<!--- Methods --->

	<cffunction name="save" returntype="boolean" access="public" output="false" hint="Persists the current state of the comment to the db." >

		<cfset variables.onStatic() />

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

					WHERE #getTableKey()# = <cfqueryparam sqltype="BIGINT" value="#getID()#" />;
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

	<cffunction name="create" returntype="Models.Comment" access="public" hint="Static method. Creates a new empty comment in the db and returns an instance of this comment." >
		<cfargument name="UserID" required="true" type="numeric" />
		<cfargument name="RecipeID" required="true" type="numeric" />
		<cfargument name="Datasource" type="string" required="true" hint="The name of the datasource to use for queries." />

		<cfset variables.onInitialized() />

		<cfif isValid("integer", arguments.UserID) IS false AND arguments.UserID IS 0 >
			<cfthrow message="Error creating new comment" detail="The UserID you passed is an invalid integer or is 0: #arguments.UserID#" />
		</cfif>

		<cfif isValid("integer", arguments.RecipeID) IS false AND arguments.RecipeID IS 0 >
			<cfthrow message="Error creating new comment" detail="The RecipeID you passed is an invalid integer or is 0: #arguments.RecipeID#" />
		</cfif>

		<cfset var CreateComment = queryNew("") />

		<cfset variables.setRecipeID( ID=arguments.RecipeID ) />
		<cfset variables.setUserID( ID=arguments.UserID ) />
		<cfset variables.setDateTimeCreated( Date=createODBCTime(now()) ) />

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

		<cfset variables.setCommentID( Data=CreateComment[ getTableKey() ] ) />
		
		<cfreturn variables.init(
			ID=CreateComment[ getTableKey() ],
			Datasource=arguments.Datasource
		) />
	</cffunction>

	<cffunction name="load" returntype="boolean" access="private" output="false" hint="Fills this objects instance with data from the db." >

		<cfset var CommentData = queryNew("") />
		<cfset var CommentCreator = "" />

		<cfquery name="CommentData" datasource="#getDatasource()#" >
			SELECT #getTableColumns()#
			FROM #getTableName()#
			WHERE #getTableKey()# = <cfqueryparam sqltype="BIGINT" value="#getID()#" />
		</cfquery>

		<cfset variables.setRecipeID( ID=CommentData.RecipeID ) />
		<cfset variables.setCommentText( Data=CommentText ) />
		<cfset variables.setDateTimeCreated( Date=DateTimeCreated ) />

		<cfset CommentCreator = createObject("component", "Models.User").init( 
			ID=CommentData.CreatedByUser,
			Datasource=getDatasource()
		) />

		<cfset variables.setCreatedByUser( UserInstance=CommentCreator ) />

		<cfreturn true />
	</cffunction>
 
	<cffunction name="init" access="public" returntype="Components.Comment" output="false" hint="Constructor, returns an initialized comment." >
		<cfargument name="ID" type="numeric" required="true" hint="" />
		<cfargument name="Datasource" type="string" required="true" hint="The name of the datasource to use for queries." />

		<cfset variables.onInitialized() />

		<cfif len(arguments.Datasource) IS 0 >
			<cfthrow message="Error when initializing comment" detail="The 'Datasource' argument appears to be empty" />
		</cfif>

		<cfset variables.setDataSource( Name= trim(arguments.Datasource) ) />

		<cfif exists( ID=arguments.ID, Datasource=arguments.Datasource ) IS false >
			<cfthrow message="Error when initializing comment" detail="No comment with this #getTableKey()# exists: #arguments.ID#" />
		</cfif>

		<cfset variables.setCommentID( ID=arguments.ID ) >
		<cfset variables.load() />

		<cfset variables.IsStatic = false />

		<cfreturn this />
	</cffunction>

</cfcomponent>