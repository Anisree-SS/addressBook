<cfoutput>
<cfhtmltopdf>
    <div class="w-100" >
        <table>
            <thead>
                <tr>
                    <th>Photo</th>
                    <th>Name</th>
                    <th>Gender</th>
                    <th>DOB</th>
                    <th>Address</th>
                    <th>Email Id</th>
                    <th>Phone</th> 
                </tr>
            </thead>
            <tbody>
                <cfset contacts = EntityLoad("displayORM")>
                <cfloop array="#contacts#" index="contact">
                    <cfif session.userId Eq contact.getuserId()>
                        <tr>
                            <td><img src="./assets/uploads/#contact.getPhoto()#" alt="Profile" width='40' height='40'></td>
                            <td>#contact.getFirstName()# #contact.getLastName()#</td>
                            <td>#contact.getGender()#</td>
                            <td>#contact.getDOB()#</td>
                            <td>#contact.getAddress()# #contact.getstreet()# #contact.getPincode()#</td>
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