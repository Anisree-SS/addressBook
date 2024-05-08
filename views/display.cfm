<cfoutput>
<cfif session.isLogin>
    <div class="d-flex justify-content-end bg-light m-5 mb-4 gap-2 p-2">
        <img src="./assets/images/pdf.png" alt="pdf format" class="downloadIcon">
        <img src="./assets/images/excel.png" alt="excel format" class="downloadIcon">
        <img src="./assets/images/print.jpg" alt="print" class="downloadIcon">
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
                <button type="button" class="btn-primary btn modalBtn" >
                    CREATE CONTACT
                </button>
                <div class="modal" id="myModal">
                    <div class="modal-dialog bgColor p-2 d-flex">
                        <div class="modal-content border-0">
                            <div class="m-5 mb-2 bgColor">
                                <center><h6 class="modal-title text-primary fw-bold p-1">CREATE CONTACT</h6></center>
                            </div>
                            <center><p  class="errorMsgHeight mb-0" id="saveContactValidationMsg"></p></center>
                            <div class="modal-body mt-0">
                                <form action="?action=display" method="post" id="createForm" enctype="multipart/form-data">
                                    <p class="mb-0 text-primary fw-bold">Personal Contact</p>
                                    <hr class="mt-0">
                                    <div class="d-flex justify-content-between mb-4">
                                        <div>
                                            <input type="hidden" name="intContactId" id="intContactId">
                                            <label class="text-primary" for="strTitle">Title *</label><br>
                                            <select id="strTitle" name="strTitle">
                                                <option value=""></option>
                                                <option value="Miss" <!---cfif variables.strRole EQ "Miss">selected</cfif--->>Miss</option>
                                                <option value="Mr" <!---cfif variables.strRole EQ "Mr">selected</cfif--->>Mr</option>
                                                <option value="Mrs" <!---cfif variables.strRole EQ "Mrs">selected</cfif--->>Mrs</option>
                                            </select>
                                        </div>
                                        <div>
                                            <label class="text-primary" for="strFirstName">First Name *</label><br>
                                            <input type="text" name="strFirstName" id="strFirstName" placeholder="Your first name">
                                        </div>
                                        <div>
                                            <label class="text-primary" for="strLastName">Last Name *</label><br>
                                            <input type="text" name="strLastName" id="strLastName" placeholder="Your last name">
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <label class="text-primary" for="strGender">Gender *</label><br>
                                            <select id="strGender" name="strGender">
                                                <option value=""></option>
                                                <option value="Male" <!---cfif variables.strRole EQ "Male">selected</cfif--->>Male</option>
                                                <option value="Female" <!---cfif variables.strRole EQ "Female">selected</cfif--->>Female</option>
                                                <option value="Other" <!---cfif variables.strRole EQ "Other">selected</cfif--->>Other</option>
                                            </select>
                                        </div>
                                        <div>
                                            <label class="text-primary" for="dateDOB">Date Of Birth *</label><br>
                                            <input type="date" name="dateDOB" id="dateDOB" >
                                        </div>
                                    </div>
                                    <div class="d-flex-column justify-content-start mt-4">
                                        <label class="text-primary" for="filePhoto">Upload Photo *</label><br>
                                        <input type="file" name="filePhoto" id="filePhoto" class="uploadfile" accept=".jpg, .jpeg, .png">
                                    </div>
                                    <p class="mb-0 text-primary fw-bold mt-2">Contact Details</p>
                                    <hr  class="mt-0">
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <label class="text-primary" for="strAddress">Address * </label><br>
                                            <input type="text" name="strAddress" id="strAddress" placeholder="Your Address"  class="uploadfile">
                                        </div>
                                        <div>
                                            <label class="text-primary" for="strStreet">Street * </label><br>
                                            <input type="text" name="strStreet" id="strStreet" placeholder="Your Street"  class="uploadfile">
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-between mt-2 ">
                                        <div>
                                            <label class="text-primary" for="intPincode">PinCode * </label><br>
                                            <input type="text" name="intPincode" id="intPincode" placeholder="Pincode"  class="uploadfile">
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-between mt-2">
                                        <div>
                                            <label class="text-primary" for="strEmailId">Email Id * </label><br>
                                            <input type="text" name="strEmailId" id="strEmailId" placeholder="Email"  class="uploadfile">
                                        </div>
                                        <div>
                                            <label class="text-primary" for="intPhone">Phone Number * </label><br>
                                            <input type="text" name="intPhone" id="intPhone" placeholder="Phone number"  class="uploadfile">
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
                            <div class="p-3">
                                <img src="./assets/images/profile.png" class="profileImg">
                            </div>
                        </div>
                    </div>
                </div>
            </div>  
        </div>  
        <div class="bg-light ms-5 w-75">
            <table class="w-100">
				<thead>
					<tr class="text-primary">
                        <th class="text-light">Photo</th>
						<th>Name</th>
						<th>Email</th>
						<th>Phone number</th>
                        <th></th>
                        <th></th>
					</tr>
				</thead>
				<tbody>
					<cfset persons = EntityLoad("ormFunction")>
					<cfloop array="#persons#" index="person">
						<tr>
                            <td><img src="#person.getPhoto()#"></td>
							<td>#person.getFirstName()# #person.getLastName()#</td>
							<td>#person.getEmail()#</td>
							<td>#person.getPhone()#</td>
                            <th><button type="button" class="btn btn-outline-primary buttonListStyle m-0" >EDIT</button></th>
                            <th><button type="button" class="btn btn-outline-primary buttonListStyle m-0" >DELETE</button></th>
                            <th><button type="button" class="btn btn-outline-primary buttonListStyle m-0" >VIEW</button></th>
						</tr>
					</cfloop>
				</tbody>
			</table>
        </div>
    </div>
</cfif>
</cfoutput>