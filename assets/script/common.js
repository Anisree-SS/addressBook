$(document).ready(function() {
    $('#login').click(function() {
        $("#validationMsg").text("");
        var strUserName = $('#strUserName').val().trim(); 
        var strPassword = $('#strPassword').val().trim();
        if (strUserName == ''|| strPassword =='' ){  
            $('#loginValidationMsg').html('Required user name and password').css("color", "red");
            return false;
        }
        $.ajax({
            url: './controllers/contact.cfc?method=doLogin',
            type: 'post',
            data:  {strUserName: strUserName , strPassword:strPassword},
            dataType:"json",
            success: function(response) {
                if (response.success){
                    $("#loginValidationMsg").text('Login successfull !!!!').css("color", "green");
                    setTimeout(function() {
                        window.location.href="?action=display";
                    },1000);

                } else {
                    $("#loginValidationMsg").text('Invalid user name or password !!!!').css("color", "red");
                }
            },
        });
        return false;
    });

    $('#signUp').click(function() {
        $("#signUpValidationMsg").text("");
        var strFullName = $('#strFullName').val().trim();
        var strEmail = $('#strEmail').val().trim();
        var strUserName = $('#strUserName').val().trim();
        var strPassword = $('#strPassword').val().trim();
        if(validation()){
            $.ajax({
                url: './controllers/contact.cfc?method=checkUser',
                type: 'post',
                data:  {strFullName:strFullName,strEmail:strEmail,strUserName: strUserName,strPassword:strPassword},
                dataType:"json",
                success: function(response) {
                    if (response.success){
                        $("#signUpValidationMsg").html(response.msg).css("color", "green");
                        setTimeout(function() {
                            window.location.href="?action=login";
                        },1000);

                    } else {
                        $("#signUpValidationMsg").html(response.msg).css("color", "red");
                    }
                },
            });
        }
        return false;
    });

    $('#createForm').on("submit",function() {
        $("#saveContactValidationMsg").text("");
        var strEmailId=$('#strEmailId').val().trim();
        if(contactValidation()){
            $.ajax({
                url: './controllers/contact.cfc?method=checkContact',
                type: 'post',
                data:  { strEmailId:strEmailId },
                dataType:"json",
                success: function(response) {
                    if (response.success){
                        uploadContact();                        
                    } else {
                        $("#saveContactValidationMsg").html(response.msg).css("color", "red");
                    }
                },
            });
        }
        return false;
    });

    function uploadContact(){
        var intContactId = $('#intContactId').val().trim();
        var strTitle = $('#strTitle').val().trim();
        var strFirstName = $('#strFirstName').val().trim();
        var strLastName = $('#strLastName').val().trim();
        var strGender = $('#strGender').val().trim();
        var dateDOB=$('#dateDOB').val().trim();
        var filePhoto=$('#filePhoto').val().trim();
        var strAddress=$('#strAddress').val().trim();
        var strStreet=$('#strStreet').val().trim();
        var intPhone=$('#intPhone').val().trim();
        var strEmailId=$('#strEmailId').val().trim();
        var intPincode=$('#intPincode').val().trim();
        $.ajax({
            url: './models/contact.cfc?method=uploadContact',
            type: 'post',
            data:  {
                intContactId:intContactId,
                strTitle:strTitle,
                strFirstName:strFirstName,
                strLastName: strLastName,
                strGender:strGender,
                dateDOB:dateDOB,
                filePhoto:filePhoto,
                strAddress:strAddress,
                strStreet:strStreet,
                intPhone:intPhone,  
                strEmailId:strEmailId,
                intPincode:intPincode
            },
            dataType:"json",
            success: function(response) {
                if (response.success){
                    $("#saveContactValidationMsg").html("contact uploades successfull").css("color", "green");
                    setTimeout(function() {
                        window.location.href="?action=display";
                    },1000);
                
                } else {
                    $("#saveContactValidationMsg").html("enable to upload contact").css("color", "red");
                    return false;
                }
            },
        });   
    }

    function validation(){
        var strFullName = $('#strFullName').val().trim(); 
        var strEmail = $('#strEmail').val().trim();
        var strUserName = $('#strUserName').val().trim();
        var strPassword = $('#strPassword').val().trim();
        var strConfirmPass = $('#strConfirmPass').val().trim();
        var specialChar = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/;
        var alphabets = /[A-z]/g;
        var number = /[0-9]/g;
        var emailformate=/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
        var specialCharName = specialChar.test(strFullName);
        var numberName = number.test(strFullName);
        var specialCharUserName = specialChar.test(strUserName);
        var numberUserName = number.test(strUserName);
        var errorMsg='';
        $("#signUpValidationMsg").text(""); 
        if((strFullName=='')||(strEmail=='')||(strUserName=="")||(strPassword=="")||(strConfirmPass=='')){
            errorMsg="All fields required";
        }
        else{
            if(((specialCharName) || (numberName))){
                errorMsg+="Full name should be in string"; 
            }
            if (!strEmail.match(emailformate)){
                errorMsg+="Enter valid email address!!";
            }
            if (((specialCharUserName) || (numberUserName))){
                errorMsg+="User name should be in string"; 
            }
            if(strPassword!=''){
                if(strPassword.match(" "))
                    errorMsg+="Space is not allowed";
                else{
                    var specialChar = specialChar.test(strPassword);
                    var  alphabets= alphabets.test(strPassword);
                    var number = number.test(strPassword);
                    if(!((specialChar) && (alphabets) && (number))){
                        errorMsg+="Password should contain all type values";
                    }
                }
            }
            if((strConfirmPass!='')&&(strConfirmPass!=strPassword)){
                errorMsg+="Password is not matching";
            }
        }
        if(errorMsg !==''){
            $("#signUpValidationMsg").html(errorMsg).css("color", "red");
            return false;
        }
        else{
            return true;
        }

    }

    function contactValidation(){
        $("#saveContactValidationMsg").text("");
        var strTitle = $('#strTitle').val().trim();
        var strFirstName = $('#strFirstName').val().trim();
        var strLastName = $('#strLastName').val().trim();
        var strGender = $('#strGender').val().trim();
        var dateDOB=$('#dateDOB').val().trim();
        var filePhoto=$('#filePhoto').val().trim();
        var strAddress=$('#strAddress').val().trim();
        var strStreet=$('#strStreet').val().trim();
        var intPhone=$('#intPhone').val().trim();
        var strEmailId=$('#strEmailId').val().trim();
        var intPincode=$('#intPincode').val().trim();
        var specialChar = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/;
        var emailformate=/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
        var number = /[0-9]/g;
        var specialCharName = specialChar.test(strFirstName);
        var numberName = number.test(strFirstName);
        var specialCharLastName = specialChar.test(strLastName);
        var numberLastName = number.test(strLastName);
        var errorMsg='';
        if((strTitle=='')||(strFirstName=='')||(strLastName=='')||(strGender=='')||(dateDOB=='')||(strAddress=='')||(strStreet=='')||(intPhone=='')||(strEmailId=='')||(intPincode=='')||(filePhoto=='')){
            errorMsg+="All fields required";
        }
        else{
            if(((specialCharName) || (numberName))){
                errorMsg+="First name should be in string "; 
            }
            if(((specialCharLastName) || (numberLastName))){
                errorMsg+="Last name should be in string "; 
            }
            if (!strEmailId.match(emailformate)){
                errorMsg+="Enter valid email address!! ";
            }
            if(isNaN(intPhone)||(intPhone.length!=10))
                errorMsg+="Enter valid phone number!!  ";     
            if(isNaN(intPincode)) 
                errorMsg+="Enter valid pincode!! ";  
            if(!isNaN(strAddress)) 
                errorMsg+="Address must contains letters ";    
        }
        if(errorMsg !==''){
            $("#saveContactValidationMsg").html(errorMsg).css("color", "red");
            return false;
        }
        else{
            return true;
        }

    }

});