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

    $('#signUpForm').on('submit',function() {
        $("#signUpValidationMsg").text("");
        var strEmail = $('#strEmail').val().trim();
        var strUserName = $('#strUserName').val().trim();
        $("#signUpValidationMsg").html('');
        if(validation()){
            $.ajax({
                url: './controllers/contact.cfc?method=checkUser',
                type: 'post',
                data: {strEmail:strEmail,strUserName:strUserName} ,
                dataType: 'json',
                success: function(response) {
                    if (response.success){
                        uploadUser();
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
                    var date =new Date(response.DOB);
                    var strDate = date.getFullYear() + "/" + (date.getMonth()+1) + "/" + date.getDate();
                    $("#Name").html(response.Title+' '+response.FirstName+' '+response.LastName);
                    $('#Gender').html(response.Gender);
                    $('#DOB').html(strDate);
                    $('#Address').html(response.Address+' '+response.Street);
                    $('#Pincode').html(response.Pincode);
                    $('#EmailId').html(response.Email);
                    $('#Phone').html(response.Phone);
                    $('.picture').attr('src','./assets/uploads/'+response.Photo);
                }
            }
        });
        return false;
    });
    
    $("#createBtn").click(function() { 
        $("#createForm")[0].reset();
        $('#heading').html("CREATE CONTACT");
        $('.picture').attr('src','./assets/images/profile.png');
    }); 

    $(".editBtn").click(function(){
        var intContactId =$(this).attr("data-id"); 
        $('#heading').html("EDIT CONTACT");
        $.ajax({
            url: './models/contact.cfc?method=getContact',
            type: 'post',
            data:  {intContactId: intContactId},
            dataType:"json",
            success:function(response){
                if(response.success){
                    var date =new Date(response.DOB);
                    var strDate = date.getFullYear() + '-' + ('0' + (date.getMonth() + 1)).slice(-2) + '-' + ('0' + date.getDate()).slice(-2);
                    $('#intContactId').prop('value',intContactId);
                    $('#strTitle').prop("value", response.Title);
                    $("#strFirstName").prop("value",response.FirstName);
                    $("#strLastName").prop("value",response.LastName);
                    $('#strGender').prop("value",response.Gender);
                    $('#dateDOB').prop("value",strDate);
                    $('#strAddress').prop("value",response.Address);
                    $('#strStreet').prop("value",response.Street);
                    $('#intPincode').prop("value",response.Pincode);
                    $('#strEmailId').prop("value",response.Email);
                    $('#intPhone').prop("value",response.Phone);
                    $('.picture').attr('src','./assets/uploads/'+response.Photo);
                }
            }
        });
        return false;
    });

    $('#printBtn').click(function(){
        var printArea = $('#areaToPrint').html();
        $('body').html(printArea);
        window.print();
        window.location.href="?action=display";
    });

    function uploadUser(){
        var strFullName = $('#strFullName').val().trim(); 
        var strEmail = $('#strEmail').val().trim();
        var strUserName = $('#strUserName').val().trim();
        var strPassword = $('#strPassword').val().trim();
        var fileUserPhoto = $("#fileUserPhoto")[0].files[0];
        var formData = new FormData();
        formData.append('strFullName', strFullName);
        formData.append('strEmail', strEmail);
        formData.append('strUserName', strUserName);
        formData.append('strPassword', strPassword);
        formData.append('fileUserPhoto', fileUserPhoto);
        $("#signUpValidationMsg").html('');
        $.ajax({
            url: './models/contact.cfc?method=saveUser',
            type: 'post',
            data: formData,
            contentType: false, 
            processData: false, 
            dataType: 'json',
            success: function(response) {
                if(response){
                    $("#signUpValidationMsg").html('Registration completed').css("color", "green");
                    setTimeout(function() {
                        window.location.href="?action=login";
                    },1000);
                }
                else
                    $("#signUpValidationMsg").html('Unable to complete Registration').css("color", "red");
            }
        });
    }

    function uploadContact(){
        $("#saveContactValidationMsg").html('');
        var intContactId = $('#intContactId').val().trim();
        var strTitle = $('#strTitle').val().trim();
        var strFirstName = $('#strFirstName').val().trim();
        var strLastName = $('#strLastName').val().trim();
        var strGender = $('#strGender').val().trim();
        var dateDOB=$('#dateDOB').val().trim();
        var strAddress=$('#strAddress').val().trim();
        var strStreet=$('#strStreet').val().trim();
        var intPhone=$('#intPhone').val().trim();
        var strEmailId=$('#strEmailId').val().trim();
        var intPincode=$('#intPincode').val().trim();
        var filePhoto = $('#filePhoto')[0].files[0];
        var formData = new FormData();
        formData.append('intContactId', intContactId);
        formData.append('strTitle', strTitle);
        formData.append('strFirstName', strFirstName);
        formData.append('strLastName', strLastName);
        formData.append('strGender', strGender);
        formData.append('dateDOB', dateDOB);
        formData.append('filePhoto', filePhoto); 
        formData.append('strAddress', strAddress);
        formData.append('strStreet', strStreet);
        formData.append('intPhone', intPhone);
        formData.append('strEmailId', strEmailId);
        formData.append('intPincode', intPincode);
        $("#saveContactValidationMsg").html('');
        $.ajax({
            url: './models/contact.cfc?method=uploadContact',
            type: 'post',
            data: formData,
            contentType: false, 
            processData: false, 
            dataType: 'json',
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
        try {
            var fileUserPhoto = $("#fileUserPhoto")[0].files[0].name;
        } catch (error) {
            errorMsg+=error;
        }
        $("#signUpValidationMsg").text(""); 
        if((strFullName=='')||(strEmail=='')||(strUserName=="")||(strPassword=="")||(strConfirmPass=='')||(errorMsg!=='')){
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
        var strTitle = $('#strTitle').val().trim();
        var strFirstName = $('#strFirstName').val().trim();
        var strLastName = $('#strLastName').val().trim();
        var strGender = $('#strGender').val().trim();
        var dateDOB=$('#dateDOB').val().trim();
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
        try {
            var filePhoto = $("#filePhoto")[0].files[0].name;
        } catch (error) {
            errorMsg+=error;
        }
        $("#saveContactValidationMsg").html('');
        if((strTitle=='')||(strFirstName=='')||(strLastName=='')||(strGender=='')||(dateDOB=='')||(strAddress=='')||(strStreet=='')||(intPhone=='')||(strEmailId=='')||(intPincode=='')||(errorMsg!='')){
            errorMsg="All fields required";
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
        if(errorMsg != ''){
            $("#saveContactValidationMsg").html(errorMsg).css("color", "red");
            return false;
        }
        else{
            return true;
        }
    }

});