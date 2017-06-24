<cfcomponent output="true" extends="Model" >
<cfprocessingdirective pageEncoding="utf-8"  />

	<cfset RecipeID = 0 />
	<cfset DateCreated = createDate(666, 6, 6) />
	<cfset DateTimeLastModified = createDateTime(666, 6, 6, 0, 0) />
	<cfset CreatedByUser = 0 />
	<cfset LastModifiedByUser = 0 />

	<cfset Comments = arrayNew(1) /> <!--- An array of Comment.cfc's --->
	<cfset Ingredients = "" />
	<cfset Description = "" />
	<cfset Picture = 0 />
	<cfset Instructions = "" />
	<cfset Name = "" />

	<cfset TableName = "Recipes" />
	<cfset TableKey = "RecipeID" />
	<cfset TableColumns = "Name,DateCreated,DateTimeLastModified,CreatedByUser,LastModifiedByUser,Ingredients,Description,Picture,Instructions" />

	<!--- Getters --->

	<cffunction name="getRecipeID" access="public" output="false" returntype="numeric" >
		<cfreturn variables.RecipeID />
	</cffunction>

	<cffunction name="getDateCreated" access="public" output="false" returntype="date" >
		<cfreturn variables.DateCreated />
	</cffunction> 

	<cffunction name="getDateTimeLastModified" access="public" output="false" returntype="date" >
		<cfreturn variables.DateTimeLastModified />
	</cffunction> 

	<cffunction name="getCreatedByUser" access="public" output="false" returntype="Models.User" >
		<cfreturn variables.CreatedByUser />
	</cffunction> 

	<cffunction name="getLastModifiedByUser" access="public" output="false" returntype="Models.User" >
		<cfreturn variables.LastModifiedByUser />
	</cffunction> 

	<cffunction name="getComments" access="public" output="false" returntype="Models.Comment" >
		<cfreturn variables.Comments />
	</cffunction> 

	<cffunction name="getIngredients" access="public" output="false" returntype="string" >
		<cfreturn variables.Ingredients />
	</cffunction> 

	<cffunction name="getDescription" access="public" output="false" returntype="string" >
		<cfreturn variables.Description />
	</cffunction>

	<cffunction name="getPicture" access="public" output="false" returntype="numeric" >
		<cfreturn variables.Picture />
	</cffunction> 

	<cffunction name="getInstructions" access="public" output="false" returntype="string" >
		<cfreturn variables.Instructions />
	</cffunction>

	<cffunction name="getName" access="public" output="false" returntype="string" >
		<cfreturn variables.Name />
	</cffunction>

	<!--- Setters --->

	<cffunction name="setRecipeID" access="private" output="false" hint="" >
		<cfargument name="ID" type="numeric" required="true" hint="" />

		<cfset variables.RecipeID = arguments.ID />
	</cffunction>

	<cffunction name="setDateCreated" access="private" output="false" hint="" >
		<cfargument name="Date" type="date" required="true" hint="" />

		<cfset variables.DateCreated = LSParseDateTime(arguments.Date) />
	</cffunction> 

	<cffunction name="setDateTimeLastModified" access="public" output="false" hint="" >
		<cfargument name="Date" type="date" required="true" hint="" />

		<cfset variables.DateTimeLastModified = LSParseDateTime(arguments.Date) />
	</cffunction> 

	<cffunction name="setCreatedByUser" access="private" output="false" hint="" >
		<cfargument name="UserInstance" type="Models.User" required="true" hint="" />

		<cfset variables.CreatedByUser = arguments.UserInstance />
	</cffunction> 

	<cffunction name="setLastModifiedByUser" access="public" output="false" hint="" >
		<cfargument name="UserInstance" type="Models.User" required="true" hint="" />

		<cfset variables.LastModifiedByUser = arguments.UserInstance />
	</cffunction> 

	<cffunction name="setComments" access="public" output="false" hint="" >
		<cfargument name="Comments" type="array" required="true" hint="" />

		<cfset variables.Comments = arguments.Comments />
	</cffunction> 

	<cffunction name="setIngredients" access="public" output="false" hint="" >
		<cfargument name="Data" type="string" required="true" hint="" />

		<cfset variables.Ingredients = arguments.Data />
	</cffunction> 

	<cffunction name="setDescription" access="public" output="false" hint="" >
		<cfargument name="Data" type="string" required="true" hint="" />

		<cfset variables.Description = arguments.Data />
	</cffunction>

	<cffunction name="setPicture" access="public" output="false" hint="" >
		<cfargument name="ID" type="numeric" required="true" hint="" />

		<cfset variables.Picture = arguments.ID />
	</cffunction> 

	<cffunction name="setInstructions" access="public" output="false" hint="" >
		<cfargument name="Data" type="string" required="true" hint="" />

		<cfset variables.Instructions = arguments.Data />
	</cffunction>

	<cffunction name="setName" access="public" output="false" hint="" >
		<cfargument name="Data" type="string" required="true" hint="" />

		<cfset variables.Name = arguments.Data />
	</cffunction>

	<!--- Methods --->

	<cffunction name="exists" returntype="boolean" access="public" output="false" hint="Static method. Checks whether the object exists or not in the db" >
		<cfargument name="ID" type="numeric" required="true" hint="ID of the recipe you want to check for" />

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

	<cffunction name="save" returntype="boolean" access="public" output="false" hint="" >

		<cfset onStatic() />

		<cfif exists( ID=getRecipeID() ) IS false >
			<cfthrow message="You can't update a recipe that doesn't exist: #getRecipeID()#" />
			<cfreturn false />
		</cfif>

		<cfset var UpdateRecipe = queryNew("") />
		
		<cftransaction action="begin" >
			<cftry>
				<cfquery name="UpdateRecipe" datasource="#getDatasource()#" >
					UPDATE #getTableName()#
					SET	
						DateCreated = <cfqueryparam sqltype="DATE" value="#getDateCreated()#" />,
						DateTimeLastModified = <cfqueryparam sqltype="TIMESTAMP" value="#getDateTimeLastModified()#" />,
						CreatedByUser = <cfqueryparam sqltype="BIGINT" value="#getCreatedByUser().getUserID()#" />,
						LastModifiedByUser = <cfqueryparam sqltype="BIGINT" value="#getLastModifiedByUser().getUserID()#" />,
						Ingredients = <cfqueryparam sqltype="LONGVARCHAR" value="#getIngredients()#" />,
						Description = <cfqueryparam sqltype="LONGVARCHAR" value="#getDescription()#" />,
						Picture = <cfqueryparam sqltype="BIGINT" value="#getPicture()#" />,
						Instructions = <cfqueryparam sqltype="LONGVARCHAR" value="#getInstructions()#" />

					WHERE #getTableKey()# = <cfqueryparam sqltype="CF_SQL_BIGINT" value="#getRecipeID()#" />;
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

	<cffunction name="createNew" returntype="numeric" access="public" hint="Static method. Creates a new empty recipe in the db, returns the ID of the new record" output="false" >
		<cfargument name="UserID" required="true" type="numeric" />
		<cfargument name="Name" required="true" type="string" />
		<cfargument name="Datasource" type="string" required="true" hint="The name of the datasource to use for queries." />

		<cfset onInitialized() />

		<cfif len(arguments.Name) IS 0 >
			<cfthrow message="Error creating recipe. The recipe name is empty." />
		</cfif>

		<cfif len(arguments.UserID) IS 0 >
			<cfthrow message="Error creating recipe. The UserID is 0." />
		</cfif>

		<cfset var CreateRecipe = queryNew("") />

		<cftransaction action="begin" >
			<cftry>
				<cfquery name="CreateRecipe" datasource="#arguments.Datasource#" >
					INSERT INTO #getTableName()# (
						DateCreated,
						DateTimeLastModified,
						CreatedByUser,
						LastModifiedByUser,
						Ingredients,
						Description,
						Picture,
						Instructions,
						Name
					)
					VALUES (
						<cfqueryparam sqltype="DATE" value="#createODBCdate(now())#" />,
						<cfqueryparam sqltype="TIMESTAMP" value="#createODBCdatetime(now())#" />,
						<cfqueryparam sqltype="BIGINT" value="#arguments.UserID#" />,
						<cfqueryparam sqltype="BIGINT" value="#arguments.UserID#" />,
						<cfqueryparam sqltype="LONGVARCHAR" value="#getIngredients()#" />,
						<cfqueryparam sqltype="LONGVARCHAR" value="#getDescription()#" />,
						<cfqueryparam sqltype="BIGINT" value="#getPicture()#" />,
						<cfqueryparam sqltype="LONGVARCHAR" value="#getInstructions()#" />,
						<cfqueryparam sqltype="LONGVARCHAR" value="#trim(arguments.Name)#" />
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

		<cfset setRecipeID( ID=CreateRecipe.RecipeID ) />
		<cfreturn CreateRecipe.RecipeID />
	</cffunction>

	<cffunction name="load" returntype="boolean" access="private" output="false" hint="" >

		<cfset var GetRecipeData = queryNew("") />
		<cfset var RecipeOwner = "" />

		<cfquery name="GetRecipeData" datasource="#getDatasource()#" >
			SELECT #getTableColumns()#
			FROM #getTableName()#
			WHERE #getTableKey()# = <cfqueryparam sqltype="BIGINT" value="#getRecipeID()#" />
		</cfquery>

		<cfif GetRecipeData.RecordCount GT 0 >
			<cfset setDateCreated( Date=GetRecipeData.DateCreated ) />
			<cfset setDateTimeLastModified( Date=GetRecipeData.DateTimeLastModified ) />
			<cfset setIngredients( Data=GetRecipeData.Ingredients ) />
			<cfset setDescription( Data=GetRecipeData.Description ) />
			<cfset setPicture( ID=GetRecipeData.Picture ) />
			<cfset setInstructions( Data=GetRecipeData.Instructions ) />
			<cfset setName( Data=GetRecipeData.Name ) />

		<cfelse>
			<cfthrow message="Error when loading recipe data. There appears to be no recipe with this #getTableKey()#: #getRecipeID()#" />
			<cfreturn false />
		</cfif>

		<cfset RecipeOwner = createObject("component", "Models.User").init( 
			ID=GetRecipeData.CreatedByUser,
			Datasource=getDatasource()
		) />

		<cfset setCreatedByUser( UserInstance=RecipeOwner ) />

		<cfif GetRecipeData.LastModifiedByUser IS GetRecipeData.CreatedByUser >
			<cfset setLastModifiedByUser( UserInstance=RecipeOwner ) />
		<cfelse>

			<cfset setLastModifiedByUser( 
				UserInstance = createObject("component", "Models.User").init( 
					ID=GetRecipeData.LastModifiedByUser,
					Datasource=getDatasource()
				)
			) />

		</cfif>

		<cfreturn true />
	</cffunction>

	<cffunction name="getData" returntype="query" access="public" output="false" hint="Static method. Fetch data from a specific recipe or multiple recipes." >
		<cfargument name="ColumnList" type="string" required="false" default="" hint="List of columns you want to fetch data from." />
		<cfargument name="ID" type="numeric" required="false" default="0" hint="ID of the recipe you want to fetch data for. If you leave this out you get all recipes." />
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

	<cffunction name="init" access="public" returntype="Models.Recipe" output="false" hint="Constructor, returns an initialized recipe." >
		<cfargument name="ID" type="numeric" required="true" hint="" />
		<cfargument name="Datasource" type="string" required="true" hint="The name of the datasource to use for queries." />

		<cfif len(arguments.Datasource) IS 0 >
			<cfthrow message="Error when initializing recipe. The datasource argument appears to be empty" />
		</cfif>

		<cfset variables.setDataSource( Name= trim(arguments.Datasource) ) />

		<cfif variables.exists( ID=arguments.ID ) IS false >
			<cfthrow message="Error when initializing recipe. No recipe with this #getTableKey()# exists: #arguments.ID#" />
		</cfif>

		<cfset variables.setRecipeID( ID=arguments.ID ) >
		<cfset variables.load() />

		<cfset variables.IsStatic = false />

		<cfreturn this />
	</cffunction>

</cfcomponent>