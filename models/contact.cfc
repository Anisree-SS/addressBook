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

    <cffunction name="checkContact" access="remote" returnType="boolean">
        <cfargument name="strEmailId" required="true" type="string">
        <cfquery name='qryCheckContact'>
            select 1 
            from contactTable
            where email=<cfqueryparam value="#arguments.strEmailId#" cfsqltype="cf_sql_varchar">
            AND userId=<cfqueryparam value="#session.userId#" cfsqltype="cf_sql_varchar">
        </cfquery>  
        <cfif qryCheckContact.recordCount>
            <cfreturn false>
            <cfelse>
                <cfreturn true>
        </cfif>
    </cffunction>

    <cffunction name="uploadContact" access="remote" returnFormat="json">
        <cfargument name="strTitle" required="true" type="string">
        <cfargument name="strFirstName" required="true" type="string">
        <cfargument name="strLastName" required="true" type="string">
        <cfargument name="strGender" required="true" type="string">
        <cfargument name="dateDOB" required="true" type="any">
        <cfargument name="filePhoto" required="true" type="string">
        <cfargument name="strAddress" required="true" type="string">
        <cfargument name="strStreet" required="true" type="string">
        <cfargument name="strEmailId" required="true" type="string">
        <cfargument name="intPhone" required="true" type="numeric">
        <cfargument name="intPincode" required="true" type="numeric">
        <cfset local.success = ''>

        <cfset local.path = ExpandPath("assets/uploads")>
        <!---cffile action ="uploadAll" destination ="#local.path#" nameConflict ="MakeUnique" filefield="#arguments.filePhoto#">
        <cfset local.image = cffile.serverFile--->
        <cfquery name="qrySaveContact" result="qryAddContact">
            insert into contactTable(Title,FirstName,LastName,Gender,DOB,Photo,Address,Street,Email,userId,Pincode,Phone)
            values(
                <cfqueryparam value="#arguments.strTitle#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#arguments.strFirstName#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#arguments.strLastName#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#arguments.strGender#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#arguments.dateDOB#" cfsqltype="cf_sql_date">,
                <cfqueryparam value="#arguments.filePhoto#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#arguments.strAddress#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#arguments.strStreet#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#arguments.strEmailId#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#session.userId#" cfsqltype="cf_sql_integer">,
                <cfqueryparam value="#arguments.intPincode#" cfsqltype="cf_sql_integer">,
                <cfqueryparam value="#arguments.intPhone#" cfsqltype="cf_sql_varchar">
            )
        </cfquery>
        <cftry>
            <cfif qryAddContact.recordCount>
                <cfset local.success = true>
            </cfif>
            <cfcatch type="any"> 
                <cfset local.success = false>
            </cfcatch>
        </cftry>
        <cfreturn {"success":local.success}>
    </cffunction>
    

</cfcomponent>