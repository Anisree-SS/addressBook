<cfcomponent>
    <cffunction name="doLogin" access="remote" returnType="query">
        <cfargument name="strEmail" required="true" type="string">
        <cfargument name="strPassword" required="true" type="string">
        <cfquery name="qryDoLogin">
            select userId,fullName,Profile
            from addressBookLogin
            where emailId=<cfqueryparam value="#arguments.strEmail#" cfsqltype="cf_sql_varchar">
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
                <cfreturn {"success":true}>
        </cfif>
    </cffunction>

    <cffunction name="saveUser" access="remote"  returnFormat="json">
        <cfargument name="strFullName" required="true" type="string">
        <cfargument name="strEmail" required="true" type="string">
        <cfargument name="strUserName" required="true" type="string">
        <cfargument name="strPassword" required="true" type="string">
        <cfargument name='fileUserPhoto' required='true' type='any'>
        <cfset local.strPassword=Hash(arguments.strPassword,"MD5")>
        <cfset local.result = {}>
        <cfset local.path = ExpandPath("../assets/uploads/")>
        <cffile action="upload" destination="#local.path#" nameConflict="MakeUnique" filefield="fileUserPhoto">
        <cfset local.profile = cffile.serverFile>
        <cfquery name="qrySaveUser" result="qryAddUser">
            insert into addressBookLogin(fullName,emailId,userName,password,Profile)
            values(
                <cfqueryparam value="#arguments.strFullName#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#arguments.strEmail#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#arguments.strUserName#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#local.strPassword#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#local.profile#" cfsqltype="cf_sql_varchar">
            )
        </cfquery>
        <cftry>
            <cfif qryAddUser.recordCount>
                <cfset local.result.success = true>
                <cfset local.result.msg="Registration completed">
            </cfif>
            <cfcatch type="any"> 
                <cfset local.success = false>
                <cfset local.result.msg="Unable to complete Registration">
            </cfcatch>
        </cftry>
        <cfreturn local.result>
    </cffunction>

    <cffunction name="checkContact" access="remote" returnFormat="json">
        <cfargument name="intContactId" required="true" type="numeric">
        <cfargument name="strEmailId" required="true" type="string">
        <cfquery name='qryCheckContact'>
            select 1 
            from contactTable
            where Email=<cfqueryparam value="#arguments.strEmailId#" cfsqltype="cf_sql_varchar">
            AND userId=<cfqueryparam value="#session.userId#" cfsqltype="cf_sql_integer">
            AND contactId!=<cfqueryparam value="#arguments.intContactId#" cfsqltype="cf_sql_integer">
        </cfquery>  
        <cfif qryCheckContact.recordCount>
            <cfreturn {'success':false,'msg':'Email Id already present'}>
            <cfelse>
                <cfquery name='qryCheckUserMail'>
                    select 1 
                    from addressBookLogin 
                    where emailId=<cfqueryparam value="#arguments.strEmailId#" cfsqltype="cf_sql_varchar">
                    AND userID=<cfqueryparam value="#session.userId#" cfsqltype="cf_sql_integer">
                </cfquery>
                <cfif qryCheckUserMail.recordCount>
                    <cfreturn {'success':false,'msg':'you cant create your own contact'}>
                    <cfelse>
                        <cfreturn {'success':true,'msg':''}>
                </cfif>
        </cfif>
    </cffunction>

    <cffunction name="uploadContact" access="remote" returnFormat="json">
        <cfargument name="intContactId" required='true' type="numeric">
        <cfargument name="strTitle" required="true" type="string">
        <cfargument name="strFirstName" required="true" type="string">
        <cfargument name="strLastName" required="true" type="string">
        <cfargument name="strGender" required="true" type="string">
        <cfargument name="dateDOB" required="true" type="any">
        <cfargument name="filePhoto" required="true" type="any">
        <cfargument name="strAddress" required="true" type="string">
        <cfargument name="strStreet" required="true" type="string">
        <cfargument name="strEmailId" required="true" type="string">
        <cfargument name="intPhone" required="true" type="numeric">
        <cfargument name="intPincode" required="true" type="numeric">
        <cfset local.success = ''>
        <cfset local.path = ExpandPath("../assets/uploads/")>
        <cffile action="upload" destination="#local.path#" nameConflict="MakeUnique" filefield="filePhoto">
        <cfset local.profile = cffile.serverFile>
        <cfif arguments.intContactId GT 0>
            <cfquery name="updatePage">
                update contactTable 
                set Title=<cfqueryparam value="#arguments.strTitle#" cfsqltype="cf_sql_varchar">,
                FirstName=<cfqueryparam value="#arguments.strFirstName#" cfsqltype="cf_sql_varchar">,
                LastName=<cfqueryparam value="#arguments.strLastName#" cfsqltype="cf_sql_varchar">,
                Gender=<cfqueryparam value="#arguments.strGender#" cfsqltype="cf_sql_varchar">,
                DOB=<cfqueryparam value="#arguments.dateDOB#" cfsqltype="cf_sql_date">,
                Photo=<cfqueryparam value="#local.profile#" cfsqltype="cf_sql_varchar">,
                Address=<cfqueryparam value="#arguments.strAddress#" cfsqltype="cf_sql_varchar">,
                Street=<cfqueryparam value="#arguments.strStreet#" cfsqltype="cf_sql_varchar">,
                Email=<cfqueryparam value="#arguments.strEmailId#" cfsqltype="cf_sql_varchar">,
                userId=<cfqueryparam value="#session.userId#" cfsqltype="cf_sql_integer">,
                Pincode=<cfqueryparam value="#arguments.intPincode#" cfsqltype="cf_sql_integer">,
                Phone=<cfqueryparam value="#arguments.intPhone#" cfsqltype="cf_sql_varchar">
                where contactId=<cfqueryparam value="#arguments.intContactId#" cfsqltype="cf_sql_integer">
            </cfquery>
            <cfreturn {"success":true, "msg":"contact updated successfully"}>
            <cfelse>
                <cfquery name="qrySaveContact" result="qryAddContact">
                    insert into contactTable(Title,FirstName,LastName,Gender,DOB,Photo,Address,street,Email,userId,pincode,Phone)
                    values(
                        <cfqueryparam value="#arguments.strTitle#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#arguments.strFirstName#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#arguments.strLastName#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#arguments.strGender#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#arguments.dateDOB#" cfsqltype="cf_sql_date">,
                        <cfqueryparam value="#local.profile#" cfsqltype="cf_sql_varchar">,
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
                    <cfreturn {"success":local.success,"msg":''}>
        </cfif>
    </cffunction>

    <cffunction name="getContact" access="remote" returnFormat="json">
        <cfargument name="intContactId" type="numeric"  required='true'>
        <cfquery name="forDisplay">
            select Title,FirstName,LastName,Gender,DOB,Photo,Address,street,Email,pincode,Phone
            from contactTable
            <cfif structKeyExists(arguments,"intContactId")>
                where contactId =<cfqueryparam value="#arguments.intContactId#" cfsqltype="cf_sql_integer">
                and userId =<cfqueryparam value="#session.userId#" cfsqltype="cf_sql_integer">
            </cfif>
        </cfquery>
        <cfreturn {"success":true,"Title":forDisplay.Title,"FirstName":forDisplay.FirstName,"LastName":forDisplay.LastName,"Gender":forDisplay.Gender,"DOB":forDisplay.DOB,"Address":forDisplay.Address,"Pincode":forDisplay.Pincode,"Email":forDisplay.Email,"Phone":forDisplay.Phone,"Photo":forDisplay.Photo,'Street':forDisplay.Street}>
    </cffunction>

    <cffunction name="deleteContact" access='remote' returnFormat="json">
        <cfargument name="intContactId" type="numeric" required='true'>
        <cfquery name="deleteContact">
            delete from contactTable
            where contactId=<cfqueryparam value="#arguments.intContactId#" cfsqltype="cf_sql_integer">
        </cfquery>
        <cfreturn {"success":true}>
    </cffunction>
    
</cfcomponent>