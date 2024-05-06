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
    })

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
    })

    function validation(){
        var strFullName = $('#strFullName').val().trim(); 
        var strEmail = $('#strEmail').val().trim();
        var strUserName = $('#strUserName').val().trim();
        var strPassword = $('#strPassword').val().trim();
        var strConfirmPass = $('#strConfirmPass').val().trim();
        var specialChar = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/;
        var alphabets = /[A-z]/g;
        var number = /[0-9]/g;
        errorMsg='';
        $("#signUpValidationMsg").text(""); 
        var specialCharName = specialChar.test(strFullName);
        var numberName = number.test(strFullName);
        var specialCharUserName = specialChar.test(strUserName);
        var numberUserName = number.test(strUserName);
        if((strFullName=='')||(strEmail=='')||(strUserName=="")||(strPassword=="")||(strConfirmPass=='')){
            errorMsg+="All fields required";
        }
        if(((specialCharName) || (numberName))){
            errorMsg+="Full name should be in string"; 
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
        if(errorMsg !==''){
            $("#signUpValidationMsg").html(errorMsg).css("color", "red");
            return false;
        }
        else{
            return true;
        }

    }

});