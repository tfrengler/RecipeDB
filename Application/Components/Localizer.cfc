<cfcomponent output="false" hint="Utility class for dealing with converting dates between what goes into the db, what should be stored in memory and what should be displayed" >

    <cffunction modifier="static" name="GetDBDateTime" returntype="date" access="public" output="false" >
        <cfargument name="date" type="string" required="true" />

        <cfreturn createODBCDateTime(dateConvert("local2Utc", parseDateTime(arguments.date))) />
    </cffunction>

    <cffunction modifier="static" name="GetBackendDateTime" returntype="date" access="public" output="false" >
        <cfargument name="date" type="string" required="true" />

        <cfreturn createODBCDateTime(dateConvert("utc2Local", parseDateTime(arguments.date))) />
    </cffunction>

    <cffunction modifier="static" name="GetDisplayDate" returntype="string" access="public" output="false" >
        <cfargument name="date" type="date" required="true" />

        <cfreturn dateFormat(arguments.date, "dd-mm-yyyy") />
    </cffunction>

    <cffunction modifier="static" name="GetDisplayDateTime" returntype="string" access="public" output="false" >
        <cfargument name="date" type="date" required="true" />

        <cfreturn dateTimeFormat(arguments.date, "dd-mm-yyyy HH:nn:ss") />
    </cffunction>

</cfcomponent>