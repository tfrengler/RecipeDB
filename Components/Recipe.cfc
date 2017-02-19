<cfcomponent output="false" >
<cfprocessingdirective pageEncoding="utf-8"  />

	<cfset RecipeID = 0 />
	<cfset DateCreated = createDate(1666, 6, 6) />
	<cfset DateLastModified = createDate(1666, 6, 6) />
	<cfset CreatedByUser = 0 />
	<cfset LastModifiedByUser = 0 />
	
	<cfset Comments = arrayNew(1) />
	<cfset Ingredients = "" />
	<cfset Description = "" />
	<cfset Picture = 0 />
	<cfset Instructions = "" />

	<!--- Getters --->

	<cffunction name="getRecipeID" access="public" output="false" hint="" >
		<cfreturn RecipeID />
	</cffunction>

	<cffunction name="getDateCreated" access="public" output="false" hint="" >
		<cfreturn DateCreated />
	</cffunction> 

	<cffunction name="getDateLastModified" access="public" output="false" hint="" >
		<cfreturn DateLastModified />
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

	<!--- Setters --->

	<cffunction name="setRecipeID" access="private" output="false" hint="" >
		<cfargument name="Data" type="numeric" required="true" hint="" />

		<cfset RecipeID = arguments.Data />
	</cffunction>

	<cffunction name="setDateCreated" access="private" output="false" hint="" >
		<cfargument name="Data" type="date" required="true" hint="" />

		<cfset DateCreated = arguments.Data />
	</cffunction> 

	<cffunction name="setDateLastModified" access="private" output="false" hint="" >
		<cfargument name="Data" type="date" required="true" hint="" />

		<cfset DateLastModified = arguments.Data />
	</cffunction> 

	<cffunction name="setCreatedByUser" access="private" output="false" hint="" >
		<cfargument name="Data" type="numeric" required="true" hint="" />

		<cfset CreatedByUser = arguments.Data />
	</cffunction> 

	<cffunction name="setLastModifiedByUser" access="private" output="false" hint="" >
		<cfargument name="Data" type="numeric" required="true" hint="" />

		<cfset LastModifiedByUser = arguments.Data />
	</cffunction> 

	<cffunction name="setComments" access="public" output="false" hint="" >
		<cfargument name="Data" type="string" required="true" hint="" />

		<cfset Comments = arguments.Data />
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
		<cfargument name="Data" type="numeric" required="true" hint="" />

		<cfset Picture = arguments.Data />
	</cffunction> 

	<cffunction name="setInstructions" access="public" output="false" hint="" >
		<cfargument name="Data" type="string" required="true" hint="" />

		<cfset Instructions = arguments.Data />
	</cffunction>

	<!--- Methods --->

	<cffunction name="Save" access="public" output="false" hint="" >
		<!--- SQL TO SAVE TO DB --->
	</cffunction>

	<cffunction name="Load" access="private" output="false" hint="" >
		<!--- SQL TO GET ALL THE DB DATA AND PUT IT IN THE PROPERTIES. USED BY INIT --->
	</cffunction>

	<cffunction name="init" access="public" output="false" hint="" >
		<cfargument name="ID" type="numeric" required="false" hint="" />

		<cfreturn this />
	</cffunction>

</cfcomponent>