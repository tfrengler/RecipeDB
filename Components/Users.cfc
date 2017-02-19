<cfcomponent output="false" >
<cfprocessingdirective pageEncoding="utf-8"  />

	<cfset UserID = 0 />
	<cfset SessionID = 0 />
	<cfset DateCreated = createDate(1666, 12, 31) />
	<cfset DateLastLogin = createDate(1666, 12, 31) />

	<!--- Getters --->
	<cffunction name="getDateCreated" access="public" output="false" hint="" >
				<cfreturn RecipeID />
	</cffunction>

	<cffunction name="getDateLastLogin" access="public" output="false" hint="" >
				<cfreturn RecipeID />
	</cffunction>

	<cffunction name="getSessionID" access="public" output="false" hint="" >
				<cfreturn RecipeID />
	</cffunction>

	<cffunction name="getUserID" access="public" output="false" hint="" >
				<cfreturn RecipeID />
	</cffunction>

	<!--- Setters --->

	<cffunction name="setUserID" access="private" output="false" hint="" >
		<cfargument name="Data" type="numeric" required="true" hint="" />

		<cfset UserID = arguments.Data />
	</cffunction>

	<cffunction name="setSessionID" access="private" output="false" hint="" >
		<cfargument name="Data" type="numeric" required="true" hint="" />

		<cfset SessionID = arguments.Data />
	</cffunction>

	<cffunction name="setDateCreated" access="private" output="false" hint="" >
		<cfargument name="Data" type="date" required="true" hint="" />

		<cfset DateCreated = arguments.Data />
	</cffunction>

	<cffunction name="setDateLastLogin" access="private" output="false" hint="" >
		<cfargument name="Data" type="date" required="true" hint="" />

		<cfset DateLastLogin = arguments.Data />
	</cffunction>

</cfcomponent>