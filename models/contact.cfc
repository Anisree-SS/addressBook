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
        <cfargument name='intSubID' required='false' type='numeric' default='0'>
        <cfset local.strPassword=Hash(arguments.strPassword,"MD5")>
        <cfset local.path = ExpandPath("../assets/uploads/")>
        <cfset local.result = {}>
        <cfif arguments.intSubID EQ 0>
            <cffile action="upload" destination="#local.path#" nameConflict="MakeUnique" filefield="fileUserPhoto">
            <cfset local.profile = cffile.serverFile>
            <cfelse>
                <cfset local.profile=arguments.fileUserPhoto>
        </cfif>
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
        <cfreturn {'success':local.result}>
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
                    <cfreturn {'success':false,'msg':'Its your email id'}>
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
        <cfargument name="filePhoto" required="false" type="any">
        <cfargument name="strAddress" required="true" type="string">
        <cfargument name="strStreet" required="true" type="string">
        <cfargument name="strEmailId" required="true" type="string">
        <cfargument name="intPhone" required="true" type="numeric">
        <cfargument name="intPincode" required="true" type="numeric">
        <cfargument name="aryHobbies" required="true" type="string">
        <cfset local.success = ''>
        <cfset local.hobbyArry=ListToArray(arguments.aryHobbies,',')>
        <cfif arguments.intContactId GT 0>
            <cfquery name="updatePage">
                update contactTable 
                set Title=<cfqueryparam value="#arguments.strTitle#" cfsqltype="cf_sql_varchar">,
                FirstName=<cfqueryparam value="#arguments.strFirstName#" cfsqltype="cf_sql_varchar">,
                LastName=<cfqueryparam value="#arguments.strLastName#" cfsqltype="cf_sql_varchar">,
                Gender=<cfqueryparam value="#arguments.strGender#" cfsqltype="cf_sql_varchar">,
                DOB=<cfqueryparam value="#arguments.dateDOB#" cfsqltype="cf_sql_date">,
                Address=<cfqueryparam value="#arguments.strAddress#" cfsqltype="cf_sql_varchar">,
                Street=<cfqueryparam value="#arguments.strStreet#" cfsqltype="cf_sql_varchar">,
                Email=<cfqueryparam value="#arguments.strEmailId#" cfsqltype="cf_sql_varchar">,
                userId=<cfqueryparam value="#session.userId#" cfsqltype="cf_sql_integer">,
                Pincode=<cfqueryparam value="#arguments.intPincode#" cfsqltype="cf_sql_integer">,
                Phone=<cfqueryparam value="#arguments.intPhone#" cfsqltype="cf_sql_varchar">
                where contactId=<cfqueryparam value="#arguments.intContactId#" cfsqltype="cf_sql_integer">
            </cfquery>
            <cfif arrayLen(local.hobbyArry) GT 0>
                <cfquery name="local.checkHobby">
                    select hobbyId
                    from hobbyTable
                    where contactId=<cfqueryparam value="#arguments.intContactId#" cfsqltype="cf_sql_integer">
                </cfquery>
                <cfset local.hobbyList = listToArray(valueList(local.checkHobby.hobbyId))>
                <cfloop array="#local.hobbyArry#" index="local.hobby">
                    <cfif NOT arrayFind(local.hobbyList, local.hobby)>
                        <cfquery name="insertHobby" result="">
                            insert into hobbyTable(contactId,hobbyId)
                                values(
                                    <cfqueryparam value="#arguments.intContactId#" cfsqltype="cf_sql_integer">,
                                    <cfqueryparam value="#local.hobby#" cfsqltype="cf_sql_integer">
                                )
                        </cfquery>
                    </cfif>
                </cfloop>
                <cfquery name="local.deleteHobby">
                    delete from hobbyTable
                    where contactId = <cfqueryparam value="#arguments.intContactId#" cfsqltype="cf_sql_integer">
                    AND hobbyId NOT IN (<cfqueryparam value="#ArrayToList(local.hobbyArry)#" cfsqltype="cf_sql_integer" list="true">)
                </cfquery>
                <cfelse>
                    <cfquery name="local.deleteHobby">
                        delete from hobbyTable
                        where contactId = <cfqueryparam value="#arguments.intContactId#" cfsqltype="cf_sql_integer">
                    </cfquery>
            </cfif>
            <cfreturn {"success":true, "msg":"Contact updated successfully"}>
            <cfelse>
                <cfset local.path = ExpandPath("../assets/uploads/")>
                <cffile action="upload" destination="#local.path#" nameConflict="MakeUnique" filefield="filePhoto">
                <cfset local.profile = cffile.serverFile>
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
                <cfset local.id = qryAddContact.generatedKey>
                <cfif arrayLen(local.hobbyArry) GT 0>
                    <cfloop index="i" from="1" to="#arrayLen(local.hobbyArry)#">
                        <cfquery name="qrySaveHobby" result="qryAddHobby">
                            insert into hobbyTable(contactId,hobbyId)
                            values(
                                <cfqueryparam value="#local.id#" cfsqltype="cf_sql_integer">,
                                <cfqueryparam value="#local.hobbyArry[i]#" cfsqltype="cf_sql_varchar">
                            )
                        </cfquery>
                    </cfloop>
                    <cfelse>
                        <cfquery name="local.findHobbyId">
                            select hobbyId
                            from hobbyList
                            where hobbyName =<cfqueryparam value="#local.hobby#" cfsqltype="cf_sql_varchar">
                        </cfquery>
                        <cfquery name="local.insertHobby">
                            INSERT INTO hobbyTable(hobbyId,contactId)
                            VALUES (
                                <cfqueryparam value="#local.findHobbyId.hobbyId#" cfsqltype="cf_sql_integer">,
                                <cfqueryparam value="#local.id#" cfsqltype="cf_sql_integer">
                            )
                        </cfquery>
                </cfif>
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
            select c.Title,c.FirstName,c.LastName,c.Gender,c.DOB,c.Photo,c.Address,c.street,c.Email,c.pincode,c.Phone,STRING_AGG(HL.hobbyName, ',') As Hobbies,STRING_AGG(HL.hobbyId,',') As HobbyId
            FROM contactTable c
            left JOIN hobbyTable HT ON HT.contactId = c.contactId
            left JOIN hobbyList HL ON HT.hobbyId = HL.hobbyId
            where c.contactId=<cfqueryparam value="#arguments.intContactId#" cfsqltype="cf_sql_integer">
            and userID=<cfqueryparam value="#session.userId#" cfsqltype="cf_sql_integer">
            group by c.Title,c.FirstName,c.LastName,c.Gender,c.DOB,c.Photo,c.Address,c.street,c.Email,c.pincode,c.Phone; 
        </cfquery>
        <cfreturn {"success":true,"Title":forDisplay.Title,"FirstName":forDisplay.FirstName,"LastName":forDisplay.LastName,"Gender":forDisplay.Gender,"DOB":forDisplay.DOB,"Address":forDisplay.Address,"Pincode":forDisplay.Pincode,"Email":forDisplay.Email,"Phone":forDisplay.Phone,"Photo":forDisplay.Photo,'Street':forDisplay.Street,'Hobbies':forDisplay.Hobbies,'HobbiesId':forDisplay.HobbyId}>
    </cffunction>

    <cffunction name="deleteContact" access='remote' returnFormat="json">
        <cfargument name="intContactId" type="numeric" required='true'>
        <cfquery name="deleteHobby">
            delete from hobbyTable
            where contactId=<cfqueryparam value="#arguments.intContactId#" cfsqltype="cf_sql_integer">
        </cfquery>
        <cfquery name="deleteContact">
            delete from contactTable
            where contactId=<cfqueryparam value="#arguments.intContactId#" cfsqltype="cf_sql_integer">
        </cfquery>
        <cfreturn {"success":true}>
    </cffunction>

    <cffunction name='uploadFile' access='remote' returnFormat='json'>
        <cfargument name="fileExcel" required='true' type='any'>
        <cfset variables.FileUploadpath=Expandpath("../assets/uploads/")>
        <cffile action="upload" destination="#variables.FileUploadpath#" nameConflict="MakeUnique">
        <cfset session.fileName=cffile.serverFile>
        <cfset variables.FilePath=variables.FileUploadpath&session.fileName>
        <cfspreadsheet action="read" src="#variables.FilePath#" query="spreadsheetData" headerrow="1"> 
        <cfset local.excelHead = getMetaData(spreadsheetData)>
        <cfset local.excelColumnNames = []>
        <cfloop index="i" from="1" to="#arrayLen(local.excelHead)#">
            <cfset columnhead = local.excelHead[i].name>
            <cfset arrayAppend(local.excelColumnNames, columnhead)>
        </cfloop>
        <cfquery name="qryColumnNames">
            select column_name
            from information_schema.columns
            where table_name = 'contactTable'
        </cfquery>
        <cfset local.dbColumnNames = []>
        <cfloop query="qryColumnNames">
            <cfif(!((qryColumnNames.column_name EQ 'contactId') OR (qryColumnNames.column_name EQ 'userID')))>
                <cfset arrayAppend(local.dbColumnNames, qryColumnNames.column_name)>
            </cfif>
        </cfloop>
        <cfset arrayAppend(local.dbColumnNames,'Hobbies')>
        <cfif arrayLen(local.excelColumnNames) Eq arrayLen(local.dbColumnNames)>
            <cfspreadsheet action="read" src="#variables.FilePath#" query="spreadsheetData" headerrow='1' excludeHeaderRow = "true"> 
            <cfset local.excelRow=[]>
            <cfset local.updateExcelRow=[]>
            <cfloop query="#spreadsheetData#">
                <cfset local.resultError=''>
                <cfif len(trim(spreadsheetData.Title)) EQ 0 and len(trim(spreadsheetData.FirstName)) EQ 0 and len(trim(spreadsheetData.LastName)) EQ 0 and len(trim(spreadsheetData.Gender)) EQ 0 and len(trim(spreadsheetData.DOB)) EQ 0 and len(trim(spreadsheetData.Photo)) EQ 0 and len(trim(spreadsheetData.Address)) EQ 0 and len(trim(spreadsheetData.street)) EQ 0 and len(trim(spreadsheetData.Email)) EQ 0 and len(trim(spreadsheetData.Pincode)) EQ 0 and len(trim(spreadsheetData.Phone)) EQ 0 and len(trim(spreadsheetData.Hobbies)) EQ 0 >
                    <cfset local.resultError &= "Empty row">
                <cfelse>
                    <cfif len(trim(spreadsheetData.Title)) EQ 0>
                        <cfset local.resultError&=','&'Title missing'>
                    </cfif>
                    <cfif len(trim(spreadsheetData.FirstName)) EQ 0>
                        <cfset local.resultError&=','&'FirstName missing'>
                    </cfif>
                    <cfif len(trim(spreadsheetData.LastName)) EQ 0>
                        <cfset local.resultError&=','&'LastName missing'>
                    </cfif> 
                    <cfif len(trim(spreadsheetData.Gender)) EQ 0>
                        <cfset local.resultError&=','&'Gender missing'>
                    </cfif> 
                    <cfif len(trim(spreadsheetData.DOB)) EQ 0>
                        <cfset local.resultError&=','&'DOB missing'>
                    </cfif> 
                    <cfif len(trim(spreadsheetData.Photo)) EQ 0>
                        <cfset local.resultError&=','&'Photo missing'>
                    </cfif> 
                    <cfif len(trim(spreadsheetData.Address)) EQ 0>
                        <cfset local.resultError&=','&'Address missing'>
                    </cfif> 
                    <cfif len(trim(spreadsheetData.street)) EQ 0>
                        <cfset local.resultError&=','&'street missing'>
                    </cfif>
                    <cfif len(trim(spreadsheetData.Email)) EQ 0>
                        <cfset local.resultError&=','&'Email missing'>
                    </cfif>
                    <cfif len(trim(spreadsheetData.Pincode)) EQ 0>
                        <cfset local.resultError&=','&'Pincode missing'>
                    </cfif>
                    <cfif len(trim(spreadsheetData.Phone)) EQ 0>
                        <cfset local.resultError&=','&'Phone missing'>
                    </cfif>
                    <cfset local.count = 0>
                    <cfset local.hobbyIdAry=[]>
                    <cfloop list="#spreadsheetData.Hobbies#" index="local.hobby">
                        <cfquery name="local.getHobbyId">
                            select hobbyId 
                            from hobbyList
                            where hobbyName=<cfqueryparam value="#local.hobby#" cfsqltype="cf_sql_varchar">
                        </cfquery>
                        <cfif local.getHobbyId.recordCount>
                            <cfset arrayAppend(local.hobbyIdAry,"#local.getHobbyId.hobbyId#")>
                        <cfelse>
                            <cfset count+=1>
                            <cfbreak>
                        </cfif>
                    </cfloop>
                    <cfif local.count NEQ 0>
                        <cfset local.resultError&=','&'Invalid Hobbies'>
                    </cfif>
                </cfif>
                <cfif len(local.resultError) EQ 0>
                    <cfquery name='local.qryCheckContact'>
                        select contactId
                        from contactTable
                        where Email=<cfqueryparam value="#spreadsheetData.Email#" cfsqltype="cf_sql_varchar">
                        AND userId=<cfqueryparam value="#session.userId#" cfsqltype="cf_sql_integer">
                    </cfquery>
                    <cfif qryCheckContact.recordCount EQ 0>
                        <cfquery name="insertExcel" result="insertExcelResult" datasource="demo">
                            INSERT INTO contactTable(Title,FirstName,LastName,Gender,DOB,Photo,Address,street,Email,userId,pincode,Phone)
                            values(
                                <cfqueryparam value="#spreadsheetData.Title#" cfsqltype="cf_sql_varchar">,
                                <cfqueryparam value="#spreadsheetData.FirstName#" cfsqltype="cf_sql_varchar">,
                                <cfqueryparam value="#spreadsheetData.LastName#" cfsqltype="cf_sql_varchar">,
                                <cfqueryparam value="#spreadsheetData.Gender#" cfsqltype="cf_sql_varchar">,
                                <cfqueryparam value="#spreadsheetData.DOB#" cfsqltype="cf_sql_date">,
                                <cfqueryparam value="#spreadsheetData.Photo#" cfsqltype="cf_sql_varchar">,
                                <cfqueryparam value="#spreadsheetData.Address#" cfsqltype="cf_sql_varchar">,
                                <cfqueryparam value="#spreadsheetData.street#" cfsqltype="cf_sql_varchar">,
                                <cfqueryparam value="#spreadsheetData.Email#" cfsqltype="cf_sql_varchar">,
                                <cfqueryparam value="#session.userId#" cfsqltype="cf_sql_integer">,
                                <cfqueryparam value="#spreadsheetData.Pincode#" cfsqltype="cf_sql_integer">,
                                <cfqueryparam value="#spreadsheetData.Phone#" cfsqltype="cf_sql_varchar">
                            )
                        </cfquery>
                        <cfset local.id = insertExcelResult.generatedKey>
                        <cfif arrayLen(local.hobbyIdAry) GT 0>
                            <cfloop array="#local.hobbyIdAry#" index="local.hobby">
                                <cfquery name="qrySaveHobby" result="qryAddHobby">
                                    insert into hobbyTable(contactId,hobbyId)
                                    values(
                                        <cfqueryparam value="#local.id#" cfsqltype="cf_sql_integer">,
                                        <cfqueryparam value="#local.hobby#" cfsqltype="cf_sql_integer">
                                    )
                                </cfquery>
                            </cfloop>
                        </cfif>
                        <cfset local.resultError="Added">
                    <cfelse>
                        <cfquery name="local.updatePage">
                            update contactTable 
                            set Title=<cfqueryparam value="#spreadsheetData.Title#" cfsqltype="cf_sql_varchar">,
                            FirstName=<cfqueryparam value="#spreadsheetData.FirstName#" cfsqltype="cf_sql_varchar">,
                            LastName=<cfqueryparam value="#spreadsheetData.LastName#" cfsqltype="cf_sql_varchar">,
                            Gender=<cfqueryparam value="#spreadsheetData.Gender#" cfsqltype="cf_sql_varchar">,
                            DOB=<cfqueryparam value="#spreadsheetData.DOB#" cfsqltype="cf_sql_date">,
                            Photo=<cfqueryparam value="#spreadsheetData.Photo#" cfsqltype="cf_sql_varchar">,
                            Address=<cfqueryparam value="#spreadsheetData.Address#" cfsqltype="cf_sql_varchar">,
                            Street=<cfqueryparam value="#spreadsheetData.street#" cfsqltype="cf_sql_varchar">,
                            Email=<cfqueryparam value="#spreadsheetData.Email#" cfsqltype="cf_sql_varchar">,
                            userId=<cfqueryparam value="#session.userId#" cfsqltype="cf_sql_integer">,
                            Pincode=<cfqueryparam value="#spreadsheetData.Pincode#" cfsqltype="cf_sql_integer">,
                            Phone=<cfqueryparam value="#spreadsheetData.Phone#" cfsqltype="cf_sql_varchar">
                            where contactId=<cfqueryparam value="#local.qryCheckContact.contactId#" cfsqltype="cf_sql_integer">
                        </cfquery>
                        <cfif arrayLen(local.hobbyIdAry) GT 0>
                            <cfquery name="local.checkHobby">
                                select hobbyId
                                from hobbyTable
                                where contactId=<cfqueryparam value="#local.qryCheckContact.contactId#" cfsqltype="cf_sql_integer">
                            </cfquery>
                            <cfset local.hobbyList = listToArray(valueList(local.checkHobby.hobbyId))>
                            <cfloop array="#local.hobbyIdAry#" index="local.hobby">
                                <cfif NOT arrayFind(local.hobbyList, local.hobby)>
                                    <cfquery name="insertHobby">
                                        insert into hobbyTable(contactId,hobbyId)
                                            values(
                                                <cfqueryparam value="#local.qryCheckContact.contactId#" cfsqltype="cf_sql_integer">,
                                                <cfqueryparam value="#local.hobby#" cfsqltype="cf_sql_integer">
                                            )
                                    </cfquery>
                                </cfif>
                            </cfloop>
                            <cfquery name="local.deleteHobby">
                                delete from hobbyTable
                                where contactId = <cfqueryparam value="#local.qryCheckContact.contactId#" cfsqltype="cf_sql_integer">
                                AND hobbyId NOT IN (<cfqueryparam value="#ArrayToList(local.hobbyIdAry)#" cfsqltype="cf_sql_integer" list="true">)
                            </cfquery>      
                        <cfelse>
                            <cfquery name="local.deleteHobby">
                                delete from hobbyTable
                                where contactId = <cfqueryparam value="#local.qryCheckContact.contactId#" cfsqltype="cf_sql_integer">
                            </cfquery>
                        </cfif>
                        <cfset local.resultError="Updated">
                    </cfif>
                    <cfset local.resultsUpdate = {
                        "Title": spreadsheetData.Title,
                        "FirstName": spreadsheetData.FirstName,
                        "LastName": spreadsheetData.LastName,
                        "Gender": spreadsheetData.Gender,
                        "DOB": spreadsheetData.DOB,
                        "Photo": spreadsheetData.Photo,
                        "Address": spreadsheetData.Address,
                        "street": spreadsheetData.street,
                        "Pincode": spreadsheetData.Pincode,
                        "Email":spreadsheetData.Email,
                        "Phone": spreadsheetData.Phone,
                        "Hobbies": spreadsheetData.Hobbies,
                        "Result":local.resultError
                    }>    
                    <cfset arrayAppend(local.updateExcelRow, local.resultsUpdate)>
                <cfelse>
                    <cfset local.results = {
                        "Title": spreadsheetData.Title,
                        "FirstName": spreadsheetData.FirstName,
                        "LastName": spreadsheetData.LastName,
                        "Gender": spreadsheetData.Gender,
                        "DOB": spreadsheetData.DOB,
                        "Photo": spreadsheetData.Photo,
                        "Address": spreadsheetData.Address,
                        "street": spreadsheetData.street,
                        "Pincode": spreadsheetData.Pincode,
                        "Email":spreadsheetData.Email,
                        "Phone": spreadsheetData.Phone,
                        "Hobbies": spreadsheetData.Hobbies,
                        "Result":local.resultError
                    }>    
                    <cfset arrayAppend(local.excelRow, local.results)>
                </cfif>    
            </cfloop>
            <cfloop array="#local.updateExcelRow#" index="local.index">
                <cfset arrayAppend(local.excelRow,local.index)>
            </cfloop>
            <cfset local.excelQry = queryNew("Title,FirstName,LastName,Gender,DOB,Photo,Address,street,Email,pincode,Phone,Hobbies,Result","varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar")> 
            <cfloop array="#local.excelRow#" index="local.element">
                <cfset queryAddRow(local.excelQry, local.element)>
            </cfloop>
            <cfset local.requestID = createUUID()>
            <cfset local.uniqueFileName="contactList"&local.requestID&".xlsx">
            <cfset local.excelFilePath = ExpandPath("/assets/downloads/#local.uniqueFileName#")>
            <cfspreadsheet action="write" filename="#local.excelFilePath#" query="local.excelQry" sheetname="results" overwrite="true">
            <cfset session.resultFile=local.excelFilePath>
            <cfreturn {'success':true,'msg':'Contacts updated successfully'}>
        <cfelse>
            <cfreturn {'success':false,'msg':'Some columns are missing '}>      
        </cfif>
    </cffunction>

    <cffunction name='ListHobby' access='remote' returnFormat="json">
        <cfquery name="local.ListHobby">
            select hobbyId,hobbyName
            from hobbyList
        </cfquery>
        <cfset hobbyList = []> 
        <cfloop query="local.ListHobby">
            <cfset hobby = {
                "hobbyId": local.ListHobby.hobbyId,
                "hobbyName": local.ListHobby.hobbyName
            }>
            <cfset arrayAppend(hobbyList, hobby)>
        </cfloop>
        <cfreturn serializeJSON(hobbyList)>
    </cffunction>
</cfcomponent>