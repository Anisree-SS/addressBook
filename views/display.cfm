<cfoutput>
<cfif session.isLogin>
    <div class="d-flex justify-content-end bg-light m-5 mb-4 gap-2 p-2">
        <img src="./assets/images/pdf.png" alt="pdf format" class="downloadIcon">
        <img src="./assets/images/excel.png" alt="excel format" class="downloadIcon">
        <button id='printBtn' class="btn btn-outline-none"><img src="./assets/images/print.jpg" alt="print" class="downloadIcon" title='print'></button>
    </div>
    <div class="d-flex m-5 mt-0 ">
        <div class="d-flex-column justify-content-center align-item-center bg-light p-2 px-4 gap-4">
            <div class="d-flex justify-content-center mb-2">
                <img src="./assets/images/profile.png" alt="profile" class="profileImg">
            </div>
            <div class="d-flex justify-content-center mb-2 text-primary">
                #UCase(session.fullName)#
            </div>  
            <div  class="d-flex justify-content-center mb-2">                
               <button type="button" class="btn-primary btn modalBtn" data-bs-toggle="modal" data-bs-target="##myModal">
                    CREATE CONTACT
                </button>
                
                <div class="modal bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" id="myModal">
                    <div class="modal-dialog modal-lg bgColor p-2 d-flex w-75">
                        <div class="modal-content border-0">
                            <div class="m-5 mb-2 bgColor">
                                <center>
                                    <h6 class="modal-title text-primary fw-bold p-1">#variables.strHeading#</h6>
                                </center>
                            </div>
                            <center>
                                <p  class="errorMsgHeight mb-0" id="saveContactValidationMsg"></p>
                            </center>
                            <div class="modal-body mt-0">
                                <form action="?action=display" method="post" id="createForm" enctype="multipart/form-data">
                                    <p class="mb-0 text-primary fw-bold">Personal Contact</p>
                                    <hr class="mt-0">
                                    <div class="d-flex justify-content-between mb-4">
                                        <div>
                                            <input type="hidden" name="intContactId" id="intContactId" value="#variables.intContactId#">
                                            <label class="text-primary" for="strTitle">Title *</label><br>
                                            <select id="strTitle" name="strTitle">
                                                <option value=""></option>
                                                <option value="Miss" <cfif variables.strTitle EQ "Miss">selected</cfif>>Miss</option>
                                                <option value="Mr" <cfif variables.strTitle EQ "Mr">selected</cfif>>Mr</option>
                                                <option value="Mrs" <cfif variables.strTitle EQ "Mrs">selected</cfif>>Mrs</option>
                                            </select>
                                        </div>
                                        <div>
                                            <label class="text-primary" for="strFirstName">First Name *</label><br>
                                            <input type="text" name="strFirstName" id="strFirstName" placeholder="Your first name" value="#variables.strFirstName#">
                                        </div>
                                        <div>
                                            <label class="text-primary" for="strLastName">Last Name *</label><br>
                                            <input type="text" name="strLastName" id="strLastName" placeholder="Your last name" value="#variables.strLastName#">
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <label class="text-primary" for="strGender">Gender *</label><br>
                                            <select id="strGender" name="strGender">
                                                <option value=""></option>
                                                <option value="Male" <cfif variables.strGender EQ "Male">selected</cfif>>Male</option>
                                                <option value="Female" <cfif variables.strGender EQ "Female">selected</cfif>>Female</option>
                                                <option value="Other" <cfif variables.strGender EQ "Other">selected</cfif>>Other</option>
                                            </select>
                                        </div>
                                        <div>
                                            <label class="text-primary" for="dateDOB">Date Of Birth *</label><br>
                                            <input type="date" name="dateDOB" id="dateDOB"  value="#variables.dateDOB#">
                                        </div>
                                    </div>
                                    <div class="d-flex-column justify-content-start mt-4">
                                        <label class="text-primary" for="filePhoto">Upload Photo *</label><br>
                                        <input type="file" name="filePhoto" id="filePhoto" class="uploadfile">
                                    </div>
                                    <p class="mb-0 text-primary fw-bold mt-2">Contact Details</p>
                                    <hr  class="mt-0">
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <label class="text-primary" for="strAddress">Address * </label><br>
                                            <input type="text" name="strAddress" id="strAddress" placeholder="Your Address"  class="uploadfile" value="#variables.strAddress#">
                                        </div>
                                        <div>
                                            <label class="text-primary" for="strStreet">Street * </label><br>
                                            <input type="text" name="strStreet" id="strStreet" placeholder="Your Street"  class="uploadfile" value="#variables.strStreet#">
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-between mt-2 ">
                                        <div>
                                            <label class="text-primary" for="intPincode">PinCode * </label><br>
                                            <input type="text" name="intPincode" id="intPincode" placeholder="Pincode"  class="uploadfile" value="#variables.intPincode#">
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-between mt-2">
                                        <div>
                                            <label class="text-primary" for="strEmailId">Email Id * </label><br>
                                            <input type="text" name="strEmailId" id="strEmailId" placeholder="Email"  class="uploadfile" value="#variables.strEmailId#">
                                        </div>
                                        <div>
                                            <label class="text-primary" for="intPhone">Phone Number * </label><br>
                                            <input type="text" name="intPhone" id="intPhone" placeholder="Phone number"  class="uploadfile" value="#variables.intPhone#">
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-evenly mt-4">
                                        <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">Cancel</button>
                                        <input type="submit" value="Save Data" id="saveContact" class="btn btn-outline-primary" name="submit">
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div>
                            <div class="p-5 contactImg">
                                <img src="./assets/images/profile.png" class="profileImg">
                            </div>
                        </div>
                    </div>
                </div>
            </div>  
        </div>  
        <div class="bg-light ms-5 w-75" id="areaToPrint">
            <table class="w-100">
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
                                <th><button type="button" class="btn btn-outline-primary modalBtn editBtn" data-bs-toggle="modal" data-bs-target="##myModal" data-id="#contact.getContactID()#"><a href='?action=display&intContactId=#contact.getContactID()#' class="">EDIT</a></button></th>
                                <th><button type="button" class="btn btn-outline-primary modalBtn deleteBtn" data-bs-toggle="modal" data-id="#contact.getContactID()#">DELETE</button></th>
                                <th><button type="button" class="btn btn-outline-primary modalBtn" data-bs-toggle="modal" data-bs-target="##viewModal"><a href='?action=display&intContactId=#contact.getContactID()#'>VIEW</a></button></th>
                            </tr>
                            <cfelse>
                                <cfcontinue>
                        </cfif>
					</cfloop>
				</tbody>
			</table>
        </div>
    </div>
    <div class="modal bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" id="viewModal">
        <div class="modal-dialog modal-lg bgColor p-2 d-flex w-75">
            <div class="modal-content border-0">
                <div class="m-5 mb-2 bgColor">
                    <center><h6 class="modal-title text-primary fw-bold p-1">CONTACT DETAILS</h6></center>
                </div>
                <center><p  class="errorMsgHeight mb-0" id="saveContactValidationMsg"></p></center>
                <div class="modal-body mt-0">
                   
                    <div class="d-flex justify-content-evenly">
                        <div class="d-flex-column">
                            <p class="text-primary">Name</p>
                            <p class="text-primary">Gender</p>
                            <p class="text-primary">Date of Birth</p>
                            <p class="text-primary">Address</p>
                            <p class="text-primary">Pincode</p>
                            <p class="text-primary">Email Id</p>
                            <p class="text-primary">Phone</p>
                        </div>
                        <div class="d-flex-column">
                            <p class="text-dark">#variables.strTitle# #variables.strFirstName# #variables.strLastName#</p>
                            <p class="text-dark">#variables.strGender#</p>
                            <p class="text-dark">#variables.dateDOB#</p>
                            <p class="text-dark">#variables.strAddress# #variables.strStreet#</p>
                            <p class="text-dark">#variables.intPincode#</p>
                            <p class="text-primary">#variables.strEmailId#</p>
                            <p class="text-dark">#variables.intPhone#</p>
                        </div>
                    </div>
                    <div class="d-flex justify-content-evenly mt-4">
                        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Cancel</button>
                    </div>
                </div>
                
            </div>
            <div>
                <div class="p-5 contactImg">
                    <img src="#variables.filePhoto#" class="profileImg" alt='profile'>
                </div>
            </div>
        </div>
    </div>
</cfif>
</cfoutput>