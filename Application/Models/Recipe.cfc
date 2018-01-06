<cfcomponent output="false" extends="Model" >
<cfprocessingdirective pageEncoding="utf-8"  />

	<cfset RecipeID = 0 />
	<cfset DateCreated = createDate(666, 6, 6) />
	<cfset DateTimeLastModified = createDateTime(666, 6, 6, 0, 0) />
	<cfset CreatedByUser = 0 />
	<cfset LastModifiedByUser = 0 />

	<cfset Comments = arrayNew(1) /> <!--- An array of Comment.cfc's --->
	<cfset Ingredients = "" />
	<cfset Description = "" />
	<cfset Picture = "" />
	<cfset Instructions = "" />
	<cfset Name = "" />
	<cfset Published = false />

	<cfset TableName = "Recipes" />

	<!--- Getters --->

	<cffunction name="getPublished" access="public" output="false" returntype="boolean" >
		<cfreturn variables.Published />
	</cffunction>

	<cffunction name="getID" access="public" output="false" returntype="numeric" >
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

	<cffunction name="getPicture" access="public" output="false" returntype="string" >
		<cfreturn variables.Picture />
	</cffunction> 

	<cffunction name="getInstructions" access="public" output="false" returntype="string" >
		<cfreturn variables.Instructions />
	</cffunction>

	<cffunction name="getName" access="public" output="false" returntype="string" >
		<cfreturn variables.Name />
	</cffunction>

	<!--- Setters --->

	<cffunction name="setPublished" access="public" output="false" hint="" >
		<cfargument name="status" type="boolean" required="true" hint="" />

		<cfset variables.Published = arguments.status />
	</cffunction>

	<cffunction name="setID" access="private" output="false" hint="" >
		<cfargument name="Value" type="numeric" required="true" hint="" />

		<cfset variables.RecipeID = arguments.Value />
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
		<cfargument name="ID" type="string" required="true" hint="" />

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

	<cffunction name="save" returntype="void" access="public" output="false" hint="Persists the current state of the recipe to the db." >

		<cfset variables.onStatic() />

		<cfset var UpdateRecipe = queryNew("") />
		<cfset variables.setDateTimeLastModified(Date=createODBCDateTime(now())) />
		
		<cftransaction action="begin" >
			<cftry>
				<cfquery name="UpdateRecipe" datasource="#getDatasource()#" >
					UPDATE #getTableName()#
					SET	
						DateCreated = <cfqueryparam sqltype="DATE" value="#getDateCreated()#" />,
						DateTimeLastModified = <cfqueryparam sqltype="TIMESTAMP" value="#getDateTimeLastModified()#" />,
						CreatedByUser = <cfqueryparam sqltype="BIGINT" value="#getCreatedByUser().getID()#" />,
						LastModifiedByUser = <cfqueryparam sqltype="BIGINT" value="#getLastModifiedByUser().getID()#" />,
						Ingredients = <cfqueryparam sqltype="LONGVARCHAR" value="#getIngredients()#" />,
						Description = <cfqueryparam sqltype="LONGVARCHAR" value="#getDescription()#" />,
						Picture = <cfqueryparam sqltype="LONGVARCHAR" value="#getPicture()#" />,
						Instructions = <cfqueryparam sqltype="LONGVARCHAR" value="#getInstructions()#" />,
						Name = <cfqueryparam sqltype="LONGVARCHAR" value="#getName()#" />,
						Published = <cfqueryparam sqltype="BOOLEAN" value="#getPublished()#" />

					WHERE #getTableKey()# = <cfqueryparam sqltype="BIGINT" value="#getID()#" />;
				</cfquery>

				<cftransaction action="commit" />
			<cfcatch>

				<cftransaction action="rollback" />
				<cfthrow object="#cfcatch#" />

			</cfcatch>
			</cftry>
		</cftransaction>
	</cffunction>

	<cffunction name="create" returntype="Models.Recipe" access="public" hint="Static method. Creates a new empty recipe in the db, and returns an instance of it" output="false" >
		<cfargument name="UserID" required="true" type="numeric" />
		<cfargument name="Name" required="true" type="string" />
		<cfargument name="Datasource" type="string" required="true" hint="The name of the datasource to use for queries." />

		<cfset variables.onInitialized() />
		<cfset variables.setupTableColumns( Datasource=trim(arguments.Datasource) ) />

		<cfif len(arguments.Name) IS 0 >
			<cfthrow message="Error creating recipe" detail="The recipe name you passed is empty." />
		</cfif>

		<cfif isValid("integer", arguments.UserID) IS false AND arguments.UserID IS 0 >
			<cfthrow message="Error creating new recipe" detail="The UserID you passed is an invalid integer or is 0: #arguments.UserID#" />
		</cfif>

		<cfif len(arguments.Datasource) IS 0 >
			<cfthrow message="Error creating new recipe" detail="The datasource name you passed is empty." />
		</cfif>

		<cfset variables.setDateCreated(Date=createODBCdate(now())) />
		<cfset variables.setDateTimeLastModified(Date=createODBCdatetime(now())) />
		<cfset variables.setName( Data=trim(arguments.Name) ) />

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
						Name,
						Published
					)
					VALUES (
						<cfqueryparam sqltype="DATE" value="#getDateCreated()#" />,
						<cfqueryparam sqltype="TIMESTAMP" value="#getDateTimeLastModified()#" />,
						<cfqueryparam sqltype="BIGINT" value="#arguments.UserID#" />,
						<cfqueryparam sqltype="BIGINT" value="#arguments.UserID#" />,
						<cfqueryparam sqltype="LONGVARCHAR" value="#getIngredients()#" />,
						<cfqueryparam sqltype="LONGVARCHAR" value="#getDescription()#" />,
						<cfqueryparam sqltype="LONGVARCHAR" value="#getPicture()#" />,
						<cfqueryparam sqltype="LONGVARCHAR" value="#getInstructions()#" />,
						<cfqueryparam sqltype="LONGVARCHAR" value="#getName()#" />,
						<cfqueryparam sqltype="BOOLEAN" value="#getPublished()#" />
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

		<cfreturn variables.init(
			ID=CreateRecipe[ getTableKey() ],
			Datasource=arguments.Datasource
		) />
	</cffunction>

	<cffunction name="load" returntype="void" access="private" output="false" hint="Fills this objects instance with data from the db" >

		<cfset var GetRecipeData = queryNew("") />
		<cfset var RecipeOwner = "" />

		<cfquery name="GetRecipeData" datasource="#getDatasource()#" >
			SELECT #getTableColumns()#
			FROM #getTableName()#
			WHERE #getTableKey()# = <cfqueryparam sqltype="BIGINT" value="#getID()#" />
		</cfquery>

		<cfif GetRecipeData.RecordCount GT 0 >
			<cfset variables.setDateCreated( Date=GetRecipeData.DateCreated ) />
			<cfset variables.setDateTimeLastModified( Date=GetRecipeData.DateTimeLastModified ) />
			<cfset variables.setIngredients( Data=GetRecipeData.Ingredients ) />
			<cfset variables.setDescription( Data=GetRecipeData.Description ) />
			<cfset variables.setPicture( ID=GetRecipeData.Picture ) />
			<cfset variables.setInstructions( Data=GetRecipeData.Instructions ) />
			<cfset variables.setName( Data=GetRecipeData.Name ) />
			<cfset variables.setPublished( status=GetRecipeData.Published ) />

		<cfelse>
			<cfthrow message="Error when loading recipe data. There appears to be no recipe with this #getTableKey()#: #getID()#" />
		</cfif>

		<cfset RecipeOwner = createObject("component", "Models.User").init( 
			ID=GetRecipeData.CreatedByUser,
			Datasource=getDatasource()
		) />

		<cfset variables.setCreatedByUser( UserInstance=RecipeOwner ) />

		<cfif GetRecipeData.LastModifiedByUser IS GetRecipeData.CreatedByUser >
			<cfset variables.setLastModifiedByUser( UserInstance=RecipeOwner ) />
		<cfelse>

			<cfset variables.setLastModifiedByUser( 
				UserInstance = createObject("component", "Models.User").init( 
					ID=GetRecipeData.LastModifiedByUser,
					Datasource=getDatasource()
				)
			) />

		</cfif>
	</cffunction>

	<cffunction name="init" access="public" returntype="Models.Recipe" output="false" hint="Constructor, returns an initialized recipe." >
		<cfargument name="ID" type="numeric" required="true" hint="" />
		<cfargument name="Datasource" type="string" required="true" hint="The name of the datasource to use for queries." />

		<cfset variables.onInitialized() />

		<cfif len(arguments.Datasource) IS 0 >
			<cfthrow message="Error when initializing recipe. The datasource argument appears to be empty" />
		</cfif>

		<cfset variables.setDataSource( Name=trim(arguments.Datasource) ) />
		<cfset variables.setupTableColumns( Datasource=trim(arguments.Datasource) ) />

		<cfif variables.exists( ID=arguments.ID, Datasource=arguments.Datasource ) IS false >
			<cfthrow message="Error when initializing recipe. No recipe with this #getTableKey()# exists: #arguments.ID#" />
		</cfif>

		<cfset variables.setID( Value=arguments.ID ) >
		<cfset variables.load() />

		<cfset variables.IsStatic = false />

		<cfreturn this />
	</cffunction>

</cfcomponent>