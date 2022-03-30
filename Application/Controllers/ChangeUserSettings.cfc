<cfcomponent output="false" >

    <!--- AJAX METHOD --->
    <cffunction name="main" access="public" returntype="struct" returnformat="JSON" output="false" hint="" >
        <cfargument name="newDisplayName" type="string" required="true" hint="" />
        <cfargument name="newUserName" type="string" required="true" hint="" />

        <cfset var returnData = {
            statuscode: 0,
            data: ""
        } />

        <cfif trim(len(arguments.newDisplayName)) IS 0 AND trim(len(arguments.newUserName)) IS 0 >
            <cfset returnData.statuscode = 1 />
            <cfreturn returnData />
        </cfif>

        <cfset var ChangesMade = false />
        <cfset var UserInterface = createObject("component", "Models.User") />

        <cfset var UserSearch = UserInterface.getBy(
            columnToSearchOn="UserName",
            searchOperator="equal to",
            searchData=trim(arguments.newUserName)
        ) />

        <!--- If a user tries to change their username and it happens to already exist we need to inform them --->
        <cfif session.CurrentUser.getUsername() NEQ arguments.NewUserName AND UserSearch.RecordCount GT 0 >

            <cfset returnData.statuscode = 2 />
            <cfreturn returnData />

        </cfif>

        <cfif session.CurrentUser.getDisplayName() NEQ arguments.NewDisplayName >
            <cfset session.CurrentUser.setDisplayName(Name=arguments.NewDisplayName) />
            <cfset ChangesMade = true />
        </cfif>

        <cfif session.CurrentUser.getUsername() NEQ arguments.NewUserName >
            <cfset session.CurrentUser.setUserName(Name=arguments.NewUserName) />
            <cfset ChangesMade = true />
        </cfif>

        <cfif ChangesMade >
            <cfset session.CurrentUser.save() />
        </cfif>

        <cfreturn returnData />
    </cffunction>

</cfcomponent>