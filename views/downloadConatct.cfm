<cfoutput>
<cfheader name="Content-Disposition" value="attachment;filename=file.pdf">
<cfcontent type="application/octet-stream" file="#expandPath('.')#\file.pdf" deletefile="Yes">
<cfdocument format="PDF" filename="file.pdf" overwrite="Yes">
    <div class="bg-light ms-5 w-75" >
        <table class="w-100" id="areaToPrint">
            <thead class='p-2'>
                <tr class="text-primary p-2">
                    <th class="text-light">Photo</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone number</th>
                    <th></th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <cfset contacts = EntityLoad("displayORM")>
                <cfloop array="#contacts#" index="contact">
                    <cfif session.userId Eq contact.getuserId()>
                        <tr class='m-2'>
                            <td><img src="#contact.getPhoto()#" alt="Profile"></td>
                            <td>#contact.getFirstName()# #contact.getLastName()#</td>
                            <td>#contact.getEmail()#</td>
                            <td>#contact.getPhone()#</td>
                            <th>
                                <button type="button" class="btn btn-outline-primary modalBtn editBtn" data-bs-toggle="modal" data-bs-target="##myModal" data-id="#contact.getContactID()#">EDIT</button>
                            </th>
                            <th>
                                <button type="button" class="btn btn-outline-primary modalBtn deleteBtn" data-bs-toggle="modal" data-id="#contact.getContactID()#">DELETE</button>
                            </th>
                            <th>
                                <button type="button" class="btn btn-outline-primary modalBtn viewBtn" data-bs-toggle="modal" data-bs-target="##viewModal" data-id="#contact.getContactID()#">VIEW</button>
                            </th>
                        </tr>
                        <cfelse>
                            <cfcontinue>
                    </cfif>
                </cfloop>
            </tbody>
        </table>
    </div>
</cfdocument>
</cfoutput>