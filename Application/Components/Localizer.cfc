<cfcomponent output="false" hint="Utility class for dealing with converting dates between what goes into the db, what should be stored in memory and what should be displayed" >

    <cffunction modifier="static" name="GetBackendDateTimeFromString" returntype="date" access="public" output="false" >
        <cfargument name="date" type="string" required="true" />

        <cfreturn createODBCDateTime(dateConvert("local2Utc", parseDateTime(arguments.date))) />
    </cffunction>

    <cffunction modifier="static" name="GetBackendDateTimeFromDate" returntype="date" access="public" output="false" >
        <cfargument name="date" type="date" required="true" />

        <cfreturn createODBCDateTime(dateConvert("local2Utc", arguments.date)) />
    </cffunction>

    <cffunction modifier="static" name="GetDisplayDate" returntype="string" access="public" output="false" >
        <cfargument name="date" type="date" required="true" />

        <cfset var LocalDate = dateConvert("utc2Local", arguments.date) />
        <cfreturn lsdateFormat(LocalDate, "dd-mm-yyyy") />
    </cffunction>

    <cffunction modifier="static" name="GetDisplayDateTime" returntype="string" access="public" output="false" >
        <cfargument name="date" type="date" required="true" />

        <cfset var LocalDate = dateConvert("utc2Local", arguments.date) />
        <cfreturn lsdateTimeFormat(LocalDate, "dd-mm-yyyy HH:nn:ss") />
    </cffunction>

</cfcomponent>