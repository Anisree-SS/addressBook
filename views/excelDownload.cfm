<cfoutput>
    <cfset contacts = EntityLoad("displayORM")>
    <cfset excelQry = queryNew("Title,FirstName,LastName,Gender,DOB,Photo,Address,street,Email,pincode,Phone,Hobbies","varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar")> 
    <cfloop array="#contacts#" index="contact">
        <cfif session.userId EQ contact.getuserId()>
            <cfset Title=contact.getTitle()>
            <cfset FirstName = contact.getFirstName()>
            <cfset LastName=contact.getLastName()>
            <cfset Date=contact.getDOB()>
            <cfset email = contact.getEmail()>
            <cfset Photo = contact.getPhoto()>
            <cfset phone = contact.getPhone()>
            <cfset gender=contact.getGender()>
            <cfset address=contact.getAddress()>
            <cfset street =contact.getstreet()>
            <cfset pincode=contact.getPincode()>
            <cfset Hobbies=contact.getHobbies()>
            <cfset queryAddRow(excelQry, 1)>
            <cfset querySetCell(excelQry, "Title", Title)>
            <cfset querySetCell(excelQry, "FirstName", FirstName)>
            <cfset querySetCell(excelQry, "LastName", LastName)>
            <cfset querySetCell(excelQry,"Gender",gender)>
            <cfset querySetCell(excelQry,"DOB",Date)>
            <cfset querySetCell(excelQry, "Photo", Photo)>
            <cfset querySetCell(excelQry,'Address',address)>
            <cfset querySetCell(excelQry,'Street',street)>
            <cfset querySetCell(excelQry, "Email", email)>
            <cfset querySetCell(excelQry,'PinCode',pincode)>
            <cfset querySetCell(excelQry,'Phone',Phone)>
            <cfset querySetCell(excelQry,'Hobbies',Hobbies)>
        </cfif>
    </cfloop>
    <cfset excelFilePath = ExpandPath("./contactList.xlsx")>
    <cfspreadsheet action="write" filename="#excelFilePath#" query="excelQry" sheetname="contacts">
    <cfheader name="Content-Disposition" value="attachment; filename=contactList.xlsx">
    <cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" file="#excelFilePath#" deleteFile="true">
</cfoutput>
</body>
</html>


