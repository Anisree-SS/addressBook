<cfset result=createObject("component","controllers.contact").checkLogin()>
<cfinclude template="./header.cfm">
<cfinclude template="./navbar.cfm">
<cfoutput>
    <div class="d-flex justify-content-center align-item-center postion-fixed-center mt-5 border">
        <div class="navBgColor d-flex justify-content-center align-item-center p-5 border rounded-start">
            <div class="d-flex justify-content-center align-item-center mt-5">
                <img src="../assets/images/contactBook.png" alt="Address book logo" class="login mt-3">
            </div>
        </div>
        <div class="d-flex-column justify-content-center align-item-center bg-light p-5 border-none rounded-end formWidth">
            <div class="d-flex-column justify-content-center align-item-center gap-3">
                <span class="loginTxtClr h5"><center>Sign Up</center></span>
                <center  class="errorMsgHeight"><span id="signUpValidationMsg"></span></center>
            </div>
            <div class="d-flex-column justify-content-center align-item-center pt-5 ">
                <form action="index.cfm" method="post" id='signUpForm' enctype="multipart/form-data">
                    <div class="mb-4 border-bottom">
                        <input type="text"  id="strFullName" name="strFullName" placeholder="Full Name" class='inputStyle w-100'>
                    </div>
                    <div class="mb-4 border-bottom">
                        <input type="email" id="strEmail" name="strEmail" placeholder="Email Id" class='inputStyle w-100'>
                    </div>
                    <div class="mb-4 border-bottom">
                        <input type="text"  id="strUserName" name="strUserName" placeholder="User Name" class='inputStyle w-100'>
                    </div>
                    <div class="mb-4 border-bottom">
                        <input type="password"  id="strPassword" name="strPassword" placeholder="Password" class='inputStyle w-100'>
                    </div>
                    <div class="mb-4 border-bottom">
                        <input type="password"  id="strConfirmPass" name="strConfirmPass" placeholder="Confirm Password" class='inputStyle w-100'>
                    </div>
                    <div class="mb-4 border-bottom">
                        <input type="file"  id="fileUserPhoto" name="fileUserPhoto" class='inputStyle w-100' accept="image/png, image/gif, image/jpeg">
                    </div>
                    <center>
                        <input type="submit" class="btn btn-outline-primary buttonStyle" value="Register" id="signUp" > 
                    </center>
                </form> 
            </div>
        </div>
    </div>
</body>
</cfoutput>
<html>