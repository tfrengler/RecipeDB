<cfcomponent output="false" persistent="true" extends="Model" >

	<cfproperty name="RecipeID"					type="numeric"			getter="true" setter="false" />
	<cfproperty name="DateCreated"				type="date"				getter="true" setter="false" />
	<cfproperty name="DateTimeLastModified"		type="date"				getter="true" setter="false" />
	<cfproperty name="CreatedByUser"			type="Models.User"		getter="true" setter="false" />
	<cfproperty name="LastModifiedByUser"		type="Models.User"		getter="true" setter="false" />

	<!--- <cfset variables.Comments = [] /> --->
	<cfproperty name="Ingredients" 		type="string" 		getter="true"	setter="false" />
	<cfproperty name="Description" 		type="string" 		getter="true"	setter="false" />
	<cfproperty name="Picture" 			type="string" 		getter="true"	setter="false" />
	<cfproperty name="Instructions"		type="string" 		getter="true"	setter="false" />
	<cfproperty name="Name"				type="string" 		getter="true"	setter="false" />
	<cfproperty name="Published"		type="boolean" 		getter="true"	setter="false" />

	<cfscript>
		static {
			static.TableName	= "Recipes";
			static.TableKey		= "RecipeID";
			static.TableColumns	= "Name,DateCreated,DateTimeLastModified,CreatedByUser,LastModifiedByUser,Ingredients,Description,Picture,Instructions,Published";
		}
	</cfscript>

	<!--- INSTANCE --->
	<!--- Public --->

	<cffunction name="Save" returntype="void" access="public" output="false" hint="Persists the current state of the recipe to the db." >
		<cfargument name="userID" type="numeric" required="true" hint="" />

		<cfset var LastModified = createODBCDateTime(now()) />
		<cfset var LastUpdatedByUser = null />

		<cfif variables.LastModifiedByUser.getUserID() IS arguments.userID >
			<cfset LastUpdatedByUser = variables.LastModifiedByUser.getUserID() />
		<cfelse>
			<cfset variables.LastModifiedByUser = new Models.User(arguments.userID) />
			<cfset LastUpdatedByUser = arguments.userID />
		</cfif>

		<cftransaction action="begin" >
			<cftry>
				<cfset queryExecute(
					"UPDATE #static.TableName#
					SET
						DateTimeLastModified = ?,
						LastModifiedByUser = ?,
						Ingredients = ?,
						Description = ?,
						Picture = ?,
						Instructions = ?,
						Name = ?,
						Published = ?

					WHERE #static.TableKey# = ?;"
					[
						LastModified,
						{value=variables.LastModifiedByUser.getUserID(), cfsqltype="integer"},
						variables.Ingredients,
						variables.Description,
						variables.Picture,
						variables.Instructions,
						variables.Name,
						variables.Published,
						{value=variables.RecipeID, cfsqltype="integer"}
					]
				) />

				<cfset variables.DateTimeLastModified = LastModified />

				<cftransaction action="commit" />
			<cfcatch>

				<cftransaction action="rollback" />
				<cfthrow object="#cfcatch#" />

			</cfcatch>
			</cftry>
		</cftransaction>
	</cffunction>

	<cffunction modifier="static" name="Create" returntype="Models.Recipe" access="public" hint="Static method. Creates a new empty recipe in the db, and returns an instance of it" output="false" >
		<cfargument name="userID" required="true" type="numeric" hint="The owner of the new recipe" />
		<cfargument name="name" required="true" type="string" hint="The name of the new recipe" />

		<cfif len(arguments.Name) IS 0 >
			<cfthrow message="Error creating recipe" detail="The recipe name you passed is empty." />
		</cfif>

		<cfif arguments.UserID LT 0 >
			<cfthrow message="Error creating new recipe" detail="The UserID you passed must be greater than 0: #arguments.UserID#" />
		</cfif>

		<cfif len(arguments.Datasource) IS 0 >
			<cfthrow message="Error creating new recipe" detail="The datasource name you passed is empty." />
		</cfif>

		<!--- <cfif NOT Models.User::Exists(arguments.userID) >
			<cfthrow message="" detail="" />
		</cfif> --->

		<cfset variables.DateCreated = createODBCdate(now()) />
		<cfset variables.DateTimeLastModified = createODBCdatetime(now()) />
		<cfset variables.Name = trim(arguments.Name) />

		<cfset var CreateNewRecipeResult = null />

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

				<cfset queryExecute(
					"INSERT INTO #static.TableName# (
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
					)",
					[

					],
					{result="CreateNewRecipeResult"}
				) />

				<cftransaction action="commit" />
			<cfcatch>

				<cftransaction action="rollback" />
				<cfthrow object="#cfcatch#" />

			</cfcatch>
			</cftry>
		</cftransaction>

		<cfreturn new Modelinit(
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

	<!--- CONSTRUCTOR --->

	<cffunction name="init" access="public" returntype="Models.Recipe" output="false" hint="Constructor, returns an initialized recipe." >
		<cfargument name="ID" type="numeric" required="true" hint="" />

		<cfif NOT Models.Recipe::Exists(arguments.ID) >
			<cfthrow message="Error when initializing recipe. No recipe with this #static.TableKey# exists: #arguments.ID#" />
		</cfif>

		<cfset variables.RecipeID = arguments.ID />
		<cfset Load() />

		<cfreturn this />
	</cffunction>

</cfcomponent>