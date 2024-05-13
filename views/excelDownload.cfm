<cfheader name="Content-Disposition" value="attachment; filename=contactList.xlsx">
<cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" file="#ExpandPath('./assets/downloads/contactList.xlsx')#">
<cfoutput>
    "FULL NAME", "EMAIL ID", "PHONE NUMBER",
    <cfset contacts = EntityLoad("ContactsTable")>
    <cfloop array="#contacts#" index="contact">
        <cfif session.UserId EQ contact.getAdminId()>
            <cfoutput>
                "#contact.getFirstName()# #contact.getLastName()#","#contact.getEmail()#", "#contact.getPhone()#",
            </cfoutput>
        </cfif>
    </cfloop>
</cfoutput>


