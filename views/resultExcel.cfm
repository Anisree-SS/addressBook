<cfoutput>
    <cfset local.contactData = EntityLoad("displayORM")>
    <cfset local.missingData=EntityLoad("missingDataORM")>
    <cfset local.excelQry = queryNew("Title,FirstName,LastName,Gender,DOB,Photo,Address,street,Email,pincode,Phone,Hobbies,Results","varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar")> 
    <cfloop array=#local.missingData# index="local.missing">
        <cfif session.userId EQ local.missing.getuserId()>
            <cfset queryAddRow(local.excelQry, 1)>
            <cfset querySetCell(local.excelQry, "Title", local.missing.getTitle())>
            <cfset querySetCell(local.excelQry, "FirstName", local.missing.getFirstName())>
            <cfset querySetCell(local.excelQry, "LastName", local.missing.getLastName())>
            <cfset querySetCell(local.excelQry,"Gender",local.missing.getGender())>
            <cfset querySetCell(local.excelQry,"DOB",local.missing.getDOB())>
            <cfset querySetCell(local.excelQry, "Photo",local.missing.getPhoto() )>
            <cfset querySetCell(local.excelQry,'Address',local.missing.getAddress())>
            <cfset querySetCell(local.excelQry,'Street',local.missing.getstreet())>
            <cfset querySetCell(local.excelQry, "Email", local.missing.getEmail())>
            <cfset querySetCell(local.excelQry,'PinCode',local.missing.getPincode())>
            <cfset querySetCell(local.excelQry,'Phone',local.missing.getPhone())>
            <cfset querySetCell(local.excelQry,'Hobbies',local.missing.getHobbies())>
            <cfset querySetCell(local.excelQry,'Results',local.missing.getResult())>
        </cfif>
    </cfloop>
    <cfloop array=#local.contactData# index='local.contact'>
        <cfif session.userId EQ local.contact.getuserId()>
            <cfset local.addHobby=''>
            <cfset local.Result=''>
            <cfset local.resultData=entityLoad("resultORM",{contactId=local.contact})>
            <cfif arrayLen(local.resultData)>
                <cfloop array=#local.resultData# index="local.ResultData">
                    <cfset local.Result=#local.ResultData.getResult()#>
                </cfloop>
            </cfif>
            <cfset local.hobbies=entityLoad("hobbyORM", { contactId = local.contact})>
            <cfif arrayLen(local.hobbies)>
                <cfloop array="#local.hobbies#" index="local.hobby">
                    <cfset local.hobbyList = EntityLoadByPK("hobbyListORM", local.hobby.gethobbyId())>
                    <cfset local.addHobby&=','&#local.hobbyList.gethobbyName()#>
                </cfloop>
            </cfif>
            <cfdump var="#local.Result#">
            <cfif len(local.Result) NEQ 0>
                <cfset queryAddRow(local.excelQry, 1)>
                <cfset querySetCell(local.excelQry, "Title", local.contact.getTitle())>
                <cfset querySetCell(local.excelQry, "FirstName", local.contact.getFirstName())>
                <cfset querySetCell(local.excelQry, "LastName", local.contact.getLastName())>
                <cfset querySetCell(local.excelQry,"Gender",local.contact.getGender())>
                <cfset querySetCell(local.excelQry,"DOB",local.contact.getDOB())>
                <cfset querySetCell(local.excelQry, "Photo",local.contact.getPhoto() )>
                <cfset querySetCell(local.excelQry,'Address',local.contact.getAddress())>
                <cfset querySetCell(local.excelQry,'Street',local.contact.getstreet())>
                <cfset querySetCell(local.excelQry, "Email", local.contact.getEmail())>
                <cfset querySetCell(local.excelQry,'PinCode',local.contact.getPincode())>
                <cfset querySetCell(local.excelQry,'Phone',local.contact.getPhone())>
                <cfset querySetCell(local.excelQry,'Hobbies',local.addHobby)>
                <cfset querySetCell(local.excelQry,'Results',local.Result)>
            </cfif>
        </cfif>
    </cfloop>
    <cfset excelFilePath = ExpandPath("./contactList.xlsx")>
    <cfspreadsheet action="write" filename="#excelFilePath#" query="local.excelQry" sheetname="contacts">
    <cfheader name="Content-Disposition" value="attachment; filename=Upload_Result.xlsx">
    <cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" file="#excelFilePath#" deleteFile="true">
</cfoutput>
</body>
</html>


