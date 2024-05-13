<cfoutput>
<cfhtmltopdf>
    <div class="bg-light ms-5 w-75" >
        <table class="w-100">
            <thead class='p-2'>
                <tr class="text-primary p-2">
                    <th>Photo</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone number</th>
                </tr>
            </thead>
            <tbody>
                <cfset contacts = EntityLoad("displayORM")>
                <cfloop array="#contacts#" index="contact">
                    <cfif session.userId Eq contact.getuserId()>
                        <tr class='m-2'>
                            <td><img src="./assets/uploads/#contact.getPhoto()#" alt="Profile" width='40' height='40'></td>
                            <td>#contact.getFirstName()# #contact.getLastName()#</td>
                            <td>#contact.getEmail()#</td>
                            <td>#contact.getPhone()#</td>
                        </tr>
                        <cfelse>
                            <cfcontinue>
                    </cfif>
                </cfloop>
            </tbody>
        </table>
    </div>
</cfhtmltopdf>
</cfoutput>