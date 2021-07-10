<cfcomponent output="false" >

    <cffunction modifier="static" name="getDBDate" returntype="date" access="public" output="false" >
        <cfargument name="date" type="string" required="true" />

        <cfreturn createODBCDate(dateConvert("local2Utc", parseDateTime(arguments.date))) />
    </cffunction>

    <cffunction modifier="static" name="getDBDateTime" returntype="date" access="public" output="false" >
        <cfargument name="date" type="string" required="true" />

        <cfreturn createODBCDateTime(dateConvert("local2Utc", parseDateTime(arguments.date))) />
    </cffunction>

    <cffunction modifier="static" name="getBackendDate" returntype="date" access="public" output="false" >
        <cfargument name="date" type="string" required="true" />

        <cfreturn createODBCDate(dateConvert("utc2Local", parseDateTime(arguments.date))) />
    </cffunction>

    <cffunction modifier="static" name="getBackendDateTime" returntype="date" access="public" output="false" >
        <cfargument name="date" type="string" required="true" />

        <cfreturn createODBCDateTime(dateConvert("utc2Local", parseDateTime(arguments.date))) />
    </cffunction>

    <cffunction modifier="static" name="getDisplayDate" returntype="string" access="public" output="false" >
        <cfargument name="date" type="date" required="true" />

        <cfreturn dateFormat(arguments.date, "dd-mm-yyyy") />
    </cffunction>

    <cffunction modifier="static" name="getDisplayDateTime" returntype="string" access="public" output="false" >
        <cfargument name="date" type="date" required="true" />

        <cfreturn dateTimeFormat(arguments.date, "dd-mm-yyyy HH:nn:ss") />
    </cffunction>

</cfcomponent>