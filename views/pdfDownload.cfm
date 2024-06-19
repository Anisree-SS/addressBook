<cfif session.isLogin>
    <cfoutput>
    <cfhtmltopdf>
        <table class='w-100'>
            <thead>
                <tr>
                    <th>Photo</th>
                    <th>Name</th>
                    <th>Gender</th>
                    <th>DOB</th>
                    <th>Address</th>
                    <th>Email Id</th>
                    <th>Phone</th> 
                    <th>Hobbies</th>
                </tr>
            </thead>
            <tbody>
                <cfset contacts = EntityLoad("displayORM")>
                <cfloop array="#contacts#" index="contact">
                    <cfif session.userId Eq contact.getuserId()>
                        <tr>
                            <td><img src="../assets/uploads/#contact.getPhoto()#" alt="Profile" width='20' height='20'></td>
                            <td>#contact.getFirstName()# #contact.getLastName()#</td>
                            <td>#contact.getGender()#</td>
                            <td>#contact.getDOB()#</td>
                            <td>#contact.getAddress()# #contact.getstreet()# #contact.getPincode()#</td>
                            <td>#contact.getEmail()#</td>
                            <td>#contact.getPhone()#</td>
                            <td class="hobby">#contact.getHobbies()#</td>
                        </tr>
                    </cfif>
                </cfloop>
            </tbody>
        </table>
    </cfhtmltopdf>
    </cfoutput>
    <cfelse>
        <cfinclude template="../index.cfm">
</cfif>