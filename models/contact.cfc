<cfcomponent>
    <cffunction name="doLogin" access="remote" returnType="query">
        <cfargument name="strUserName" required="true" type="string">
        <cfargument name="strPassword" required="true" type="string">
        <cfquery name="qryDoLogin">
            select userId,fullName
            from addressBookLogin
            where userName=<cfqueryparam value="#arguments.strUserName#" cfsqltype="cf_sql_varchar">
            and password=<cfqueryparam value="#arguments.strPassword#" cfsqltype="cf_sql_varchar">
        </cfquery>
        <cfreturn qryDoLogin>
    </cffunction>

    <cffunction name="checkUser" access="remote" returnFormat="json">
        <cfargument name="strEmail"  required="true" type="string">
        <cfargument name="strUserName"  required="true" type="string">
        <cfquery name="qryCheckEmail">
            select 1 
            from addressBookLogin
            where emailId=<cfqueryparam value="#arguments.strEmail#" cfsqltype="cf_sql_varchar">
        </cfquery>
        <cfif qryCheckEmail.recordCount>
            <cfreturn {"success":false,"msg":"Email Id already present"}>
            <cfelse>
                <cfquery name="qryCheckUser">
                    select 1 
                    from addressBookLogin
                    where userName=<cfqueryparam value="#arguments.strUserName#" cfsqltype="cf_sql_varchar">
                </cfquery>
                <cfif qryCheckUser.recordCount>
                    <cfreturn {"success":false,"msg":"User name already present"}>
                    <cfelse>
                        <cfreturn {"success":true}>
                </cfif>
        </cfif>
    </cffunction>

    <cffunction name="saveUser" access="remote" returnType="boolean">
        <cfargument name="strFullName" required="true" type="string">
        <cfargument name="strEmail" required="true" type="string">
        <cfargument name="strUserName" required="true" type="string">
        <cfargument name="strPassword" required="true" type="string">
        <cfset local.success = ''>
        <cfquery name="qrySaveUser" result="qryAddUser">
            insert into addressBookLogin(fullName,emailId,userName,password)
            values(
                <cfqueryparam value="#arguments.strFullName#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#arguments.strEmail#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#arguments.strUserName#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#arguments.strPassword#" cfsqltype="cf_sql_varchar">
            )
        </cfquery>
        <cftry>
            <cfif qryAddUser.recordCount>
                <cfset local.success = true>
            </cfif>
            <cfcatch type="any"> 
                <cfset local.success = false>
            </cfcatch>
        </cftry>
        <cfreturn local.success>
    </cffunction>

    <cffunction name="checkContact" access="remote" returnType="query">
        <cfargument name="strEmailId" required="true" type="string">
        <cfquery name='qryCheckContact'>
            select 1 
            from contactTable
            where email=<cfqueryparam value="#arguments.strEmailId#" cfsqltype="cf_sql_varchar">
            AND userId=<cfqueryparam value="#session.userId#" cfsqltype="cf_sql_varchar">
        </cfquery>  
        <cfdump var="#qryCheckContact#" abort>
    </cffunction>
    

</cfcomponent>