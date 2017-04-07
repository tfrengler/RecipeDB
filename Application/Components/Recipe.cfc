<cfcomponent output="false" >
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

	<!--- Getters --->

	<cffunction name="getRecipeID" access="public" output="false" hint="" >
		<cfreturn RecipeID />
	</cffunction>

	<cffunction name="getDateCreated" access="public" output="false" hint="" >
		<cfreturn DateCreated />
	</cffunction> 

	<cffunction name="getDateTimeLastModified" access="public" output="false" hint="" >
		<cfreturn DateTimeLastModified />
	</cffunction> 

	<cffunction name="getCreatedByUser" access="public" output="false" hint="" >
		<cfreturn CreatedByUser />
	</cffunction> 

	<cffunction name="getLastModifiedByUser" access="public" output="false" hint="" >
		<cfreturn LastModifiedByUser />
	</cffunction> 

	<cffunction name="getComments" access="public" output="false" hint="" >
		<cfreturn Comments />
	</cffunction> 

	<cffunction name="getIngredients" access="public" output="false" hint="" >
		<cfreturn Ingredients />
	</cffunction> 

	<cffunction name="getDescription" access="public" output="false" hint="" >
		<cfreturn Description />
	</cffunction>

	<cffunction name="getPicture" access="public" output="false" hint="" >
		<cfreturn Picture />
	</cffunction> 

	<cffunction name="getInstructions" access="public" output="false" hint="" >
		<cfreturn Instructions />
	</cffunction>

	<cffunction name="getTableName" access="public" output="false" hint="" >
		<cfreturn "Recipes" />
	</cffunction> 

	<cffunction name="getTableKey" access="public" output="false" hint="" >
		<cfreturn "RecipeID" />
	</cffunction>

	<cffunction name="getName" access="public" output="false" hint="" >
		<cfreturn Name />
	</cffunction>

	<!--- Setters --->

	<cffunction name="setRecipeID" access="private" output="false" hint="" >
		<cfargument name="ID" type="numeric" required="true" hint="" />

		<cfset RecipeID = arguments.ID />
	</cffunction>

	<cffunction name="setDateCreated" access="private" output="false" hint="" >
		<cfargument name="Date" type="date" required="true" hint="" />

		<cfset DateCreated = LSParseDateTime(arguments.Date) />
	</cffunction> 

	<cffunction name="setDateTimeLastModified" access="public" output="false" hint="" >
		<cfargument name="Date" type="date" required="true" hint="" />

		<cfset DateTimeLastModified = LSParseDateTime(arguments.Date) />
	</cffunction> 

	<cffunction name="setCreatedByUser" access="private" output="false" hint="" >
		<cfargument name="UserID" type="numeric" required="true" hint="" />

		<cfset CreatedByUser = arguments.UserID />
	</cffunction> 

	<cffunction name="setLastModifiedByUser" access="public" output="false" hint="" >
		<cfargument name="UserID" type="numeric" required="true" hint="" />

		<cfset LastModifiedByUser = arguments.UserID />
	</cffunction> 

	<cffunction name="setComments" access="public" output="false" hint="" >
		<cfargument name="Comments" type="string" required="true" hint="" />

		<cfset Comments = arguments.Comments />
	</cffunction> 

	<cffunction name="setIngredients" access="public" output="false" hint="" >
		<cfargument name="Data" type="string" required="true" hint="" />

		<cfset Ingredients = arguments.Data />
	</cffunction> 

	<cffunction name="setDescription" access="public" output="false" hint="" >
		<cfargument name="Data" type="string" required="true" hint="" />

		<cfset Description = arguments.Data />
	</cffunction>

	<cffunction name="setPicture" access="public" output="false" hint="" >
		<cfargument name="ID" type="numeric" required="true" hint="" />

		<cfset Picture = arguments.ID />
	</cffunction> 

	<cffunction name="setInstructions" access="public" output="false" hint="" >
		<cfargument name="Data" type="string" required="true" hint="" />

		<cfset Instructions = arguments.Data />
	</cffunction>

	<cffunction name="setName" access="public" output="false" hint="" >
		<cfargument name="Data" type="string" required="true" hint="" />

		<cfset Name = arguments.Data />
	</cffunction>

	<!--- Methods --->

	<cffunction name="doesRecipeExist" returntype="boolean" access="private" output="false" hint="" >
		<cfargument name="ID" type="numeric" required="true" hint="" />

		<cfset var RecipeExistenceCheck = queryNew("") />
		<cfquery name="RecipeExistenceCheck" datasource="test" >
			SELECT #getTableKey()#
			FROM #getTableName()#
			WHERE #getTableKey# = <cfqueryparam sqltype="CF_SQL_BIGINT" value="#arguments.ID#" />
		</cfquery>

		<cfif RecipeExistenceCheck.RecordCount IS 1 >
			<cfreturn true />
		</cfif>

		<cfreturn false />
	</cffunction>

	<cffunction name="save" returntype="boolean" access="public" output="false" hint="" >

		<cfif doesRecipeExist( ID=getRecipeID() ) IS false >
			<cfthrow message="You can't update a recipe that doesn't exist: #getRecipeID()#" />
			<cfreturn false />
		</cfif>

		<cfset var UpdateRecipe = queryNew("") />
		
		<cftransaction action="begin" >
			<cftry>
				<cfquery name="UpdateRecipe" datasource="test" >
					UPDATE #getTableName()#
					SET	
						DateCreated = <cfqueryparam sqltype="DATE" value="#getDateCreated()#" />,
						DateLastModified = <cfqueryparam sqltype="TIMESTAMP" value="#getDateTimeLastModified()#" />,
						CreatedByUser = <cfqueryparam sqltype="BIGINT" value="#getCreatedByUser()#" />,
						LastModifiedByUser = <cfqueryparam sqltype="BIGINT" value="#getLastModifiedByUser()#" />,
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

	<cffunction name="createNew" returntype="numeric" access="public" hint="Creates a new empty recipe in the db, returns the ID of the new record" >
		<cfargument name="UserID" required="true" type="numeric" />

		<cfset var CreateRecipe = queryNew("") />

		<cfset setDateCreated( Date=createODBCdate(now()) ) />
		<cfset setDateTimeLastModified( Date=createODBCdatetime(now()) ) />
		<cfset setCreatedByUser( UserID=arguments.UserID ) />
		<cfset setLastModifiedByUser( UserID=arguments.UserID ) />

		<cfif getRecipeID() GT 0 >
			<cfthrow message="You can't call create() on an initialized recipe: #getRecipeID()#" />
		</cfif>

		<cftransaction action="begin" >
			<cftry>
				<cfquery name="CreateRecipe" datasource="test" >
					INSERT INTO #getTableName()# (
						DateCreated,
						DateLastModified,
						CreatedByUser,
						LastModifiedByUser,
						Ingredients,
						Description,
						Picture,
						Instructions,
						Name
					)
					VALUES (
						<cfqueryparam sqltype="DATE" value="#getDateCreated()#" />,
						<cfqueryparam sqltype="TIMESTAMP" value="#getDateTimeLastModified()#" />,
						<cfqueryparam sqltype="BIGINT" value="#getCreatedByUser()#" />,
						<cfqueryparam sqltype="BIGINT" value="#getLastModifiedByUser()#" />,
						<cfqueryparam sqltype="LONGVARCHAR" value="#getIngredients()#" />,
						<cfqueryparam sqltype="LONGVARCHAR" value="#getDescription()#" />,
						<cfqueryparam sqltype="BIGINT" value="#getPicture()#" />,
						<cfqueryparam sqltype="LONGVARCHAR" value="#getInstructions()#" />,
						<cfqueryparam sqltype="LONGVARCHAR" value="#getName()#" />
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

		<cfset setRecipeID( Data=CreateRecipe.RecipeID ) />
		<cfreturn CreateRecipe.RecipeID />
	</cffunction>

	<cffunction name="load" returntype="boolean" access="private" output="false" hint="" >

		<cfset var RecipeData = queryNew("") />

		<cfquery name="RecipeData" datasource="test" >
			SELECT *
			FROM #getTableName()#
			WHERE #getTableKey()# = <cfqueryparam sqltype="BIGINT" value="#getRecipeID()#" />
		</cfquery>

		<cfif GetRecipeData.RecordCount GT 0 >
			<cfset setDateCreated( Date=GetRecipeData.DateCreated ) />
			<cfset setDateTimeLastModified( Date=GetRecipeData.DateLastModified ) />
			<cfset setCreatedByUser( UserID=GetRecipeData.CreatedByUser ) />
			<cfset setLastModifiedByUser( UserID=GetRecipeData.LastModifiedByUser ) />
			<cfset setIngredients( Data=GetRecipeData.Ingredients ) />
			<cfset setDescription( Data=GetRecipeData.Description ) />
			<cfset setPicture( ID=GetRecipeData.Picture ) />
			<cfset setInstructions( Data=GetRecipeData.Instructions ) />
			<cfset setName( Data=GetRecipeData.Name ) />

		<cfelse>
			<cfthrow message="Error when loading recipe data. There appears to be no recipe with this #getTableKey()#: #getRecipeID()#" />
			<cfreturn false />
		</cfif>

		<cfreturn true />
	</cffunction>

	<cffunction name="init" access="public" returntype="Components.Recipe" output="false" hint="Constructor, returns an initialized recipe." >
		<cfargument name="ID" type="numeric" required="true" hint="" />

		<cfif doesRecipeExist( ID=arguments.ID ) IS false >
			<cfthrow message="Error when initializing recipe. No recipe with this #getTableKey()# exists: #arguments.ID#" />
		</cfif>

		<cfset setRecipeID( ID=arguments.ID ) >
		<cfset load() />

		<cfreturn this />
	</cffunction>

</cfcomponent>