<cfset result=createObject("component","controllers.contact").checkLogin()>
<!--- <cfinclude template="header.cfm">
<cfinclude template="navbar.cfm"> --->
<cfoutput>
    <div class="d-flex justify-content-center align-item-center postion-fixed-center mt-5 pt-5 border">
        <div class="navBgColor d-flex justify-content-center align-item-center p-5 border rounded-start">
            <div class="d-flex justify-content-center align-item-center mt-5">
                <img src="./assets/images/contactBook.png" alt="Address book logo" class="login mt-3">
            </div>
        </div>
        <div class="d-flex-column justify-content-center align-item-center bg-light p-5 border-none rounded-end formWidth">
            <div class="d-flex-column justify-content-center align-item-center gap-3">
                <span class="loginTxtClr h5"><center>LOGIN</center></span>
                <center class="errorMsgHeight"><span id="loginValidationMsg"></span></center>
            </div>
            <div class="d-flex-column justify-content-center align-item-center pt-5">
                <form action="?action=display" method="post">
                    <div class="mb-4 border-secondary border-bottom">
                        <input type="text"  id="strUserName" name="strUserName" placeholder="Username" class='inputStyle'>
                    </div>
                    <div class="mb-4 border-secondary border-bottom">
                        <input type="password" class="inputStyle" id="strPassword" name="strPassword" placeholder="Password">
                    </div>
                    <center>
                        <input type="submit" class="btn btn-outline-primary buttonStyle" value="Login" id="login"> 
                    </center>
                </form> 
            </div>
            <center class="mt-3">   
                <div>
                    <spam class="text-secondary fontSize14">Or Sign In Using</span> 
                </div>     
                <div>
                    <img src="./assets/images/fb.png" alt="faceBook login" class='ponter'>
                    <img src="./assets/images/google.png" alt="google login" id='googleLogin' class='ponter'>
                </div>
                <div>
                    <span class="fontSize14">Don't have an account?</span>
                    <a href="" class="fontSize14">Register here</a>
                </div>
            </center>
        </div>
    </div>
</body>
</cfoutput>
</body>
<html>