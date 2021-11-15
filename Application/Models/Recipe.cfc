<cfcomponent output="false" persistent="true" extends="Model" >

	<cfproperty name="RecipeID"					type="numeric"			getter="true" setter="false" />
	<cfproperty name="DateTimeCreated"			type="date"				getter="true" setter="false" />
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
			static.TableColumns	= "Name,DateTimeCreated,DateTimeLastModified,CreatedByUser,LastModifiedByUser,Ingredients,Description,Picture,Instructions,Published";
		}
	</cfscript>

	<!--- INSTANCE --->
	<!--- Public --->

	<cffunction name="Save" returntype="void" access="public" output="false" hint="Persists the current state of the recipe to the db." >
		<cfargument name="userID" type="numeric" required="true" hint="" />

		<cfset var LastUpdatedByUser = null />
		<cfset var DateTimeLastModified = Components.Localizer::GetBackendDateTimeFromDate(now()) />

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
						Name = ?,
						DateTimeLastModified = ?,
						LastModifiedByUser = ?,
						Ingredients = ?,
						Description = ?,
						Picture = ?,
						Instructions = ?,
						Published = ?

					WHERE #static.TableKey# = ?;",
					[
						variables.Name,
						DateTimeLastModified,
						{value=LastUpdatedByUser, cfsqltype="integer"},
						variables.Ingredients,
						variables.Description,
						variables.Picture,
						variables.Instructions,
						variables.Published,
						{value=variables.RecipeID, cfsqltype="integer"}
					]
				) />

				<cfset variables.DateTimeLastModified = DateTimeLastModified />

				<cftransaction action="commit" />
			<cfcatch>

				<cftransaction action="rollback" />
				<cfthrow object="#cfcatch#" />

			</cfcatch>
			</cftry>
		</cftransaction>
	</cffunction>

	<!--- Private --->

	<cffunction name="Load" returntype="void" access="private" output="false" hint="Fills this objects instance with data from the db" >

		<cfset var RecipeData = queryExecute(
			"SELECT #static.TableColumns#
			FROM #static.TableName#
			WHERE #static.TableKey# = ?;",
			[
				variables.RecipeID
			]
		) />

		<cfif RecipeData.RecordCount IS 1 >

			<cfset var DateTimeCreated = parseDateTime(RecipeData.DateTimeCreated) />
			<cfset var DateTimeLastModified = parseDateTime(RecipeData.DateTimeLastModified) />

			<cfset variables.DateTimeCreated = DateTimeCreated />
			<cfset variables.DateTimeLastModified = DateTimeLastModified />
			<cfset variables.Ingredients = RecipeData.Ingredients />
			<cfset variables.Description = RecipeData.Description />
			<cfset variables.Picture = RecipeData.Picture />
			<cfset variables.Instructions = RecipeData.Instructions />
			<cfset variables.Name = RecipeData.Name />
			<cfset variables.Published = RecipeData.Published />

		<cfelse>
			<cfthrow message="Error when loading recipe data. There appears to be no recipe with this #static.TableKey#: #variables.RecipeID#" />
		</cfif>

		<cfset variables.CreatedByUser = new Models.User(RecipeData.CreatedByUser) />

		<cfif RecipeData.LastModifiedByUser IS RecipeData.CreatedByUser >
			<cfset variables.LastModifiedByUser = variables.CreatedByUser />
		<cfelse>
			<cfset variables.LastModifiedByUser = new Models.User(RecipeData.LastModifiedByUser) />
		</cfif>
	</cffunction>

	<!--- STATIC --->
	<!--- Public --->

	<cffunction modifier="static" name="Create" returntype="Models.Recipe" access="public" hint="Static method. Creates a new empty recipe in the db, and returns an instance of it" output="false" >
		<cfargument name="userID" required="true" type="numeric" hint="The owner of the new recipe" />
		<cfargument name="name" required="true" type="string" hint="The name of the new recipe" />

		<cfif len(arguments.name) IS 0 >
			<cfthrow message="Error creating recipe" detail="The recipe name you passed is empty." />
		</cfif>

		<cfif arguments.userID LT 0 >
			<cfthrow message="Error creating new recipe" detail="The UserID you passed must be greater than 0: #arguments.UserID#" />
		</cfif>

		<cfset var CreateNewRecipeResult = null />

		<cftransaction action="begin" >
			<cftry>
				<cfset queryExecute(
					"INSERT INTO #static.TableName# (
						Name,
						DateTimeCreated,
						DateTimeLastModified,
						CreatedByUser,
						LastModifiedByUser
					)
					VALUES (?,?,?,?,?)",
					[
						trim(arguments.name),
						Components.Localizer::GetBackendDateTimeFromDate(now()),
						Components.Localizer::GetBackendDateTimeFromDate(now()),
						{value=arguments.UserID, cfsqltype="integer"},
						{value=arguments.UserID, cfsqltype="integer"}
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

		<cfreturn new Models.Recipe(CreateNewRecipeResult.generatedKey) />
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