<cfset variables.profileURL= session.profileURL?session.profile:"./assets/uploads/"&session.profile>
<cfoutput>
<cfif session.isLogin>
    <div class="d-flex justify-content-end align-item-center bg-light m-5 mb-4 gap-2 p-2">
        <a href='?action=pdfDownload'>
            <img src="./assets/images/pdf.png" alt="pdf format" class="downloadIcon" title='PDF Download'>
        </a>
        <a href='?action=excelDownload'>
            <img src="./assets/images/excel.png" alt="excel format" class="downloadIcon" title='Excel Download'>
        </a>
        <button id='printBtn' class="btn btn-outline-none p-0">
            <img src="./assets/images/print.jpg" alt="print" class="downloadIcon">
        </button>
    </div>
    <div class="d-flex m-5 mt-0 col-12">
        <div class="d-flex-column justify-content-center align-item-center bg-light p-2 px-4 divheight">
            <div class="d-flex justify-content-center mb-2">
                <img src="#variables.profileURL#" alt="user profile" class="profileImg">
            </div>
            <div class="d-flex justify-content-center mb-2 text-primary">
                #UCase(session.fullName)#
            </div>  
            <div class="d-flex justify-content-center mb-2">                
                <button type="button" class="btn-primary btn modalBtn" data-bs-toggle="modal" data-bs-target="##myModal" id="createBtn">
                    CREATE CONTACT
                </button>
            </div>
            <div class="d-flex justify-content-center mb-2">
                <button type="button" class="btn-primary btn modalBtn" data-bs-toggle="modal" data-bs-target="##uploadModel" id="uploadExcel">
                    UPLOAD EXCEL
                </button>
                <div class="modal bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" id="uploadModel">
                    <div class="modal-dialog bgColor p-2 d-flex">
                        <div class="modal-content border-0">
                            <div class="m-5 mb-2 bgColor">
                                <center>
                                    <h6 class="modal-title text-primary fw-bold p-1">UPLOAD CONTACTS</h6>
                                </center>
                            </div>
                            <center>
                                <p class="errorMsgHeight mb-0" id="uploadError"></p>
                            </center>
                            <div class="modal-body mt-0">
                                <form action='?action=display' method='post' enctype='multipart/form-data' id='uploadContact'>
                                    <div class="d-flex justify-content-center mb-4">
                                        <div>
                                            <label class="text-primary" for="fileExcel">Upload Excel File *</label><br>
                                            <input type="file" name="fileExcel" id="fileExcel" class="uploadfile" value=""> 
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-evenly mt-4">
                                        <input type="button" class="btn btn-outline-dark" data-bs-dismiss="modal" value="CLOSE">
                                        <input type="submit" value="SUBMIT" class="btn btn-outline-primary" name="submit">
                                    </div>
                               </form>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" id="myModal">
                    <div class="modal-dialog modal-lg bgColor p-2 d-flex w-75">
                        <div class="modal-content border-0">
                            <div class="m-5 mb-2 bgColor">
                                <center>
                                    <h6 class="modal-title text-primary fw-bold p-1" id="heading"></h6>
                                </center>
                            </div>
                            <center>
                                <p class="errorMsgHeight mb-0" id="saveContactValidationMsg"></p>
                            </center>
                            <div class="modal-body mt-0">
                                <form action="?action=display" method="post" id="createForm" enctype="multipart/form-data">
                                    <p class="mb-0 text-primary fw-bold">Personal Contact</p>
                                    <hr class="mt-0">
                                    <div class="d-flex justify-content-between mb-4">
                                        <div>
                                            <input type="hidden" name="intContactId" id="intContactId" value="0">
                                            <label class="text-primary" for="strTitle">Title *</label><br>
                                            <select id="strTitle" name="strTitle" value="">
                                                <option value=""></option>
                                                <option value="Miss">Miss</option>
                                                <option value="Mr">Mr</option>
                                                <option value="Mrs">Mrs</option>
                                            </select>
                                        </div>
                                        <div>
                                            <label class="text-primary" for="strFirstName">First Name *</label><br>
                                            <input type="text" name="strFirstName" id="strFirstName" placeholder="Your first name" value="">
                                        </div>
                                        <div>
                                            <label class="text-primary" for="strLastName">Last Name *</label><br>
                                            <input type="text" name="strLastName" id="strLastName" placeholder="Your last name" value="">
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <label class="text-primary" for="strGender">Gender *</label><br>
                                            <select id="strGender" name="strGender">
                                                <option value=""></option>
                                                <option value="Male">Male</option>
                                                <option value="Female">Female</option>
                                                <option value="Other">Other</option>
                                            </select>
                                        </div>
                                        <div>
                                            <label class="text-primary" for="dateDOB">Date Of Birth *</label><br>
                                            <input type="text" name="dateDOB" id="dateDOB" value=''>
                                        </div>
                                    </div>
                                    <div class="d-flex-column justify-content-start mt-4">
                                        <label class="text-primary" for="filePhoto">Upload Photo *</label><br>
                                        <input type="file" name="filePhoto" id="filePhoto" class="uploadfile" accept="image/png, image/gif, image/jpeg" value=''> 
                                    </div>
                                    <p class="mb-0 text-primary fw-bold mt-2">Contact Details</p>
                                    <hr  class="mt-0">
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <label class="text-primary" for="strAddress">Address * </label><br>
                                            <input type="text" name="strAddress" id="strAddress" placeholder="Your Address"  class="uploadfile" value="">
                                        </div>
                                        <div>
                                            <label class="text-primary" for="strStreet">Street * </label><br>
                                            <input type="text" name="strStreet" id="strStreet" placeholder="Your Street"  class="uploadfile" value="">
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-between mt-2 ">
                                        <div>
                                            <label class="text-primary" for="intPincode">PinCode * </label><br>
                                            <input type="text" name="intPincode" id="intPincode" placeholder="Pincode"  class="uploadfile" value="" maxlength='6'>
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-between mt-2">
                                        <div>
                                            <label class="text-primary" for="strEmailId">Email Id * </label><br>
                                            <input type="text" name="strEmailId" id="strEmailId" placeholder="Email"  class="uploadfile" value="">
                                        </div>
                                        <div>
                                            <label class="text-primary" for="intPhone">Phone Number * </label><br>
                                            <input type="text" name="intPhone" id="intPhone" placeholder="Phone number"  class="uploadfile" value="">
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-evenly mt-4">
                                        <input type="button" class="btn btn-outline-dark" data-bs-dismiss="modal" value="CLOSE">
                                        <input type="submit" value="SUBMIT" id="saveContact" class="btn btn-outline-primary" name="submit">
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div>
                            <div class="p-5 contactImg">
                                <img src="./assets/images/profile.png" class="profileImg picture">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="bg-light ms-4 w-75 tableDiv" id='areaToPrint'>
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
                        <cfif session.userId EQ contact.getuserId()>
                            <tr class='m-2'>
                                <td><img src="./assets/uploads/#contact.getPhoto()#" alt="Profile" class='downloadIcon'></td>
                                <td>#contact.getFirstName()# #contact.getLastName()#</td>
                                <td>#contact.getEmail()#</td>
                                <td>#contact.getPhone()#</td>
                                <td>
                                    <button type="button" class="btn btn-outline-primary modalBtn editBtn" data-bs-toggle="modal" data-bs-target="##myModal" data-id="#contact.getContactID()#">EDIT</button>
                                </td>
                                <td>
                                    <button type="button" class="btn btn-outline-primary modalBtn deleteBtn" data-bs-toggle="modal" data-id="#contact.getContactID()#">DELETE</button>
                                </td>
                                <td>
                                    <button type="button" class="btn btn-outline-primary modalBtn viewBtn" data-bs-toggle="modal" data-bs-target="##viewModal" data-id="#contact.getContactID()#">VIEW</button>
                                </td>
                            </tr>
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
                    <center>
                        <h6 class="modal-title text-primary fw-bold p-1">CONTACT DETAILS</h6>
                    </center>
                </div>
                <center>
                    <p  class="errorMsgHeight mb-0" id="saveContactValidationMsg"></p>
                </center>
                <div class="modal-body mt-0">
                    <div class="d-flex-column">
                        <div class="d-flex justify-content-strat mb-2">
                            <div class="text-primary forPadding col-3">Name</div>
                            <div class="text-dark forPadding" id="Name"></div>
                        </div>
                        <div class="d-flex justify-content-start mb-2">
                            <div class="text-primary forPadding col-3">Gender</div>
                            <div class="text-dark forPadding" id="Gender"></div>
                        </div>
                        <div class="d-flex justify-content-start mb-2">
                            <div class="text-primary forPadding col-3">Date of Birth</div>
                            <div class="text-dark forPadding" id="DOB"></div>
                        </div>
                        <div class="d-flex justify-content-start mb-2">
                            <div class="text-primary forPadding col-3">Address</div>
                            <div class="text-dark forPadding" id="Address"></div>
                        </div>
                        <div class="d-flex justify-content-start mb-2">
                            <div class="text-primary forPadding col-3">Pincode</div>
                            <div class="text-dark forPadding" id="Pincode"></div>
                        </div>
                        <div class="d-flex justify-content-start mb-2">
                            <div class="text-primary forPadding col-3">Email Id</div>
                            <div class="text-primary forPadding" id="EmailId"></div>
                        </div>
                        <div class="d-flex justify-content-start mb-2">
                            <div class="text-primary forPadding col-3">Phone</div>
                            <div class="text-dark forPadding" id="Phone"></div>
                        </div>
                    </div>
                    <div class="d-flex justify-content-evenly mt-4">
                        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">CLOSE</button>
                    </div>
                </div> 
            </div>
            <div>
                <div class="p-5 contactImg">
                    <img src="./assets/images/profile.png" class="profileImg picture" alt='profile'>
                </div>
            </div>
        </div>
    </div>
</cfif>
</cfoutput>
</body>
</html>