<cfoutput>
    <cfset contacts = EntityLoad("displayORM")>
    <cfset excelQry = queryNew("Photo,Name,Gender,Email,Phone,Address,Pincode","varchar,varchar,varchar,varchar,varchar,varchar,integer")> 
    <cfloop array="#contacts#" index="contact">
        <cfif session.userId EQ contact.getuserId()>
            <cfimage name = "profilePhoto" source ="" action = "read"> 
            <cfset photo=profilePhoto>
            <cfdump var="#photo#" abort>
            <cfset name = contact.getFirstName()&" "&contact.getLastName()>
            <cfset email = contact.getEmail()>
            <cfset phone = contact.getPhone()>
            <cfset gender=contact.getGender()>
            <cfset address=contact.getAddress()&' '&contact.getstreet()>
            <cfset pincode=contact.getPincode()>
            <cfset queryAddRow(excelQry, 1)>
            <cfset querySetCell(excelQry, "Name", name)>
            <cfset querySetCell(excelQry,"Gender",gender)>
            <cfset querySetCell(excelQry, "Email", email)>
            <cfset querySetCell(excelQry, "Phone", phone)>
            <cfset querySetCell(excelQry,'Address',address)>
            <cfset querySetCell(excelQry,'PinCode',pincode)>
        </cfif>
    </cfloop>
    <cfset excelFilePath = ExpandPath("./contactList.xlsx")>
    <cfspreadsheet action="write" filename="#excelFilePath#" query="excelQry" sheetname="contacts">
    <cfheader name="Content-Disposition" value="attachment; filename=contactList.xlsx">
    <cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" file="#excelFilePath#" deleteFile="true">
</cfoutput>


