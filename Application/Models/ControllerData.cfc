<cfcomponent output="false" accessors="false" persistent="true" >

    <cfproperty name="StatusCode"   type="numeric"  getter="true" setter="false" />
    <cfproperty name="Data"         type="string"   getter="true" setter="false" />

    <cffunction access="public" name="Init" returntype="ControllerData" output="false" hint="" >
        <cfargument name="statuscode" type="numeric" required="true" />
        <cfargument name="data" type="string" required="true" />

        <cfset this.StatusCode = arguments.statuscode />
        <cfset this.Data = arguments.data />

        <cfreturn this />
    </cffunction>

</cfcomponent>