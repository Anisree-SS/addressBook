<cfoutput>
    <div class="d-flex justify-content-center align-item-center postion-fixed-center mt-5 border">
        <div class="navBgColor d-flex justify-content-center align-item-center p-5 border rounded-start">
            <div class="d-flex justify-content-center align-item-center mt-5">
                <img src="./assets/images/contactBook.png" alt="Address book logo" class="login mt-3">
            </div>
        </div>
        <div class="d-flex-column justify-content-center align-item-center bg-light p-5 border-none rounded-end formWidth">
            <div class="d-flex-column justify-content-center align-item-center gap-3">
                <span class="loginTxtClr h5"><center>Sign Up</center></span>
                <center  class="errorMsgHeight"><span id="signUpValidationMsg"></span></center>
            </div>
            <div class="d-flex-column justify-content-center align-item-center pt-5 ">
                <form action="?action=display" method="post">
                    <div class="mb-4 border-bottom">
                        <input type="text"  id="strFullName" name="strFullName" placeholder="Full Name">
                    </div>
                    <div class="mb-4 border-bottom">
                        <input type="email" id="strEmail" name="strEmail" placeholder="Email Id">
                    </div>
                    <div class="mb-4 border-bottom">
                        <input type="text"  id="strUserName" name="strUserName" placeholder="User Name">
                    </div>
                    <div class="mb-4 border-bottom">
                        <input type="password"  id="strPassword" name="strPassword" placeholder="Password">
                    </div>
                    <div class="mb-4 border-bottom">
                        <input type="password"  id="strConfirmPass" name="strConfirmPass" placeholder="Confirm Password">
                    </div>
                    <center>
                        <input type="submit" class="btn btn-outline-primary px-5" value="Register" id="signUp"> 
                    </center>
                </form> 
            </div>
        </div>
    </div>
</body>
</cfoutput>
<html>