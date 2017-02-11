<cfcomponent output="false" >
<cfprocessingdirective pageEncoding="utf-8"  />

	<cfset CommentID = 0 />
	<cfset RecipeID = 0 />
	<cfset CommentText = "" />
	<cfset UserID = 0 />
	<cfset DateCreated = createDate(1666, 6, 6) />

	<!--- Getters --->

	<cffunction name="getCommentID" access="public" output="false" hint="" >
			<cfreturn RecipeID />
	</cffunction>

	<cffunction name="getRecipeID" access="public" output="false" hint="" >
			<cfreturn RecipeID />
	</cffunction>

	<cffunction name="getCommentText" access="public" output="false" hint="" >
			<cfreturn RecipeID />
	</cffunction>

	<cffunction name="getUserID" access="public" output="false" hint="" >
			<cfreturn RecipeID />
	</cffunction>

	<cffunction name="getDateCreated" access="public" output="false" hint="" >
			<cfreturn RecipeID />
	</cffunction>

	<!--- Setters --->

	<cffunction name="setCommentID" access="private" output="false" hint="" >
		<cfargument name="Data" type="numeric" required="true" hint="" />

		<cfset CommentID = arguments.Data />
	</cffunction>

	<cffunction name="setRecipeID" access="private" output="false" hint="" >
		<cfargument name="Data" type="numeric" required="true" hint="" />

		<cfset RecipeID = arguments.Data />
	</cffunction>

	<cffunction name="setCommentText" access="public" output="false" hint="" >
		<cfargument name="Data" type="string" required="true" hint="" />

		<cfset CommentText = arguments.Data />
	</cffunction>

	<cffunction name="setUserID" access="private" output="false" hint="" >
		<cfargument name="Data" type="numeric" required="true" hint="" />

		<cfset UserID = arguments.Data />
	</cffunction>

	<cffunction name="setDateCreated" access="private" output="false" hint="" >
		<cfargument name="Data" type="date" required="true" hint="" />

		<cfset DateCreated = arguments.Data />
	</cffunction>

	<cffunction name="init" access="public" output="false" hint="" >
		<cfargument name="ID" type="numeric" required="false" hint="" />

		<cfreturn this />
	</cffunction>

</cfcomponent>