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
                    delayRedirect();

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
        var intContactId=$('#intContactId').val().trim();
        if(contactValidation()){
            $.ajax({
                url: './controllers/contact.cfc?method=checkContact',
                type: 'post',
                data:  {intContactId :intContactId, strEmailId:strEmailId },
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

    $('.deleteBtn').click(function() {
        var intContactId =$(this).attr("data-id"); 
        if(confirm("Are you sure you want delete the contact ?")){
            $.ajax({
                url: './models/contact.cfc?method=deleteContact',
                type: 'post',
                data:  {intContactId: intContactId},
                dataType:"json",
                success: function(response) {
                    if(response.success){
                        window.location.href="?action=display";
                    } 
                }, 
            });
        }
        else{
            return false;
        }
    });

    $('.viewBtn').click(function() {
        var intContactId =$(this).attr("data-id"); 
        $.ajax({
            url: './models/contact.cfc?method=getContact',
            type: 'post',
            data:  {intContactId: intContactId},
            dataType:"json",
            success:function(response){
                if(response.success){
                    $("#Name").html(response.Title+' '+response.FirstName+' '+response.LastName);
                    $('#Gender').html(response.Gender);
                    $('#DOB').html(response.DOB);
                    $('#Address').html(response.Address+' '+response.Street);
                    $('#Pincode').html(response.Pincode);
                    $('#EmailId').html(response.Email);
                    $('#Phone').html(response.Phone);
                }
            }
        });
        return false;
    });
    
    $("#createBtn").click(function() { 
        $("#createForm")[0].reset();
        $('#heading').html("CREATE CONTACT");
    }); 

    $(".editBtn").click(function(){
        var intContactId =$(this).attr("data-id"); 
        if(intContactId > 0){
            $('#heading').html("EDIT CONTACT");
            $.ajax({
                url: './models/contact.cfc?method=getContact',
                type: 'post',
                data:  {intContactId: intContactId},
                dataType:"json",
                success:function(response){
                    if(response.success){
                        $('#strTitle').prop("value", response.Title);
                        $("#strFirstName").prop("value",response.FirstName);
                        $("#strLastName").prop("value",response.LastName);
                        $('#strGender').prop("value",response.Gender);
                        $('#dateDOB').prop("value",response.DOB);
                        $('#strAddress').prop("value",response.Address);
                        $('#strStreet').prop("value",response.Street);
                        $('#intPincode').prop("value",response.Pincode);
                        $('#strEmailId').prop("value",response.Email);
                        $('#intPhone').prop("value",response.Phone);
                    }
                }
            });
            return false;
        }
    });

    $('#printBtn').click(function(){
        var css = '@page { size: landscape; }',
        printArea = document.table || document.getElementsByTagName('table')[0],
        style = document.createElement('style');
            style.media = 'print';
            if (style.styleSheet){
                style.styleSheet.cssText = css;
            } else {
                style.appendChild(document.createTextNode(css));
         }
        printArea.appendChild(style);
        window.print();
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
        $("#saveContactValidationMsg").html('');
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
                    if(response.msg==''){
                        $("#saveContactValidationMsg").html("contact created successfully").css("color", "green");
                        delayRedirect();
                    }
                    else{
                        $("#saveContactValidationMsg").html(response.msg).css("color","green");
                        delayRedirect();
                    }
                } 
                else {
                    $("#saveContactValidationMsg").html("enable to upload contact").css("color", "red");
                    return false;
                }
            },
        });   
    }

    function delayRedirect(){
        setTimeout(function() {
            window.location.href="?action=display";
        },1000);
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
        var filePhoto=$("#filePhoto")[0].files[0].name;
        //var filePhoto=$('#filePhoto').files[0].name;
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