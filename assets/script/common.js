$(document).ready(function() {
    $('#login').click(function() {
        $("#validationMsg").text("");
        var strEmail = $('#strUserName').val().trim(); 
        var strPassword = $('#strPassword').val().trim();
        var intSubID=0;
        if (strUserName == ''|| strPassword =='' ){  
            $('#loginValidationMsg').html('Required user name and password').css("color", "red");
            return false;
        }
        $.ajax({
            url: '../controllers/contact.cfc?method=doLogin',
            type: 'post',
            data:  {strEmail: strEmail , strPassword:strPassword,intSubID:intSubID},
            dataType:"json",
            success: function(response) {
                if (response.success){
                    $("#loginValidationMsg").text('Login successfull !!!!').css("color", "green");
                    window.location="../views/display.cfm";

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
                url: '../controllers/contact.cfc?method=checkUser',
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

    $('.forHobbyBtn').on('click', function() {
        $('#strHobbyList').find('option').remove();
		$.ajax({
			url: '../models/contact.cfc?method=ListHobby',
			type: 'post',
            dataType: 'json',
			success: function(response) {
				if (response.DATA || response.DATA.length > 0) {
					for (var i = 0; i < response.DATA.length; i++) {
						var hobbyId = response.DATA[i][0];
						var hobbyName = response.DATA[i][1];
                        let optionHTML = `<option value="${hobbyId}"> ${hobbyName} </option>`;
                        $('#strHobbyList').append(optionHTML); 
					}
				}
			},
			error: function(xhr, status, error) {
				console.log("Error occurred while fetching hobbies:", error);
			}
		});
	});
	
    $('#createForm').on("submit",function() {
        $("#saveContactValidationMsg").text("");
        var strEmailId=$('#strEmailId').val().trim();
        var intContactId=$('#intContactId').val().trim();
        if(contactValidation()){
            $.ajax({
                url: '../controllers/contact.cfc?method=checkContact',
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
                url: '../models/contact.cfc?method=deleteContact',
                type: 'post',
                data:  {intContactId: intContactId},
                dataType:"json",
                success: function(response) {
                    if(response.success){
                        window.location="../views/display.cfm";
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
            url: '../models/contact.cfc?method=getContact',
            type: 'post',
            data:  {intContactId: intContactId},
            dataType:"json",
            success:function(response){
                if(response.success){
                    var date =new Date(response.DOB);
                    var strDate = date.getFullYear() + '-' + ('0' + (date.getMonth() + 1)).slice(-2) + '-' + ('0' + date.getDate()).slice(-2);
                    $("#Name").html(response.Title+' '+response.FirstName+' '+response.LastName);
                    $('#Gender').html(response.Gender);
                    $('#DOB').html(strDate);
                    $('#Address').html(response.Address+' '+response.Street);
                    $('#Pincode').html(response.Pincode);
                    $('#EmailId').html(response.Email);
                    $('#Phone').html(response.Phone);
                    $('#Hobbies').html(response.Hobbies);
                    $('.picture').attr('src','../assets/uploads/'+response.Photo);
                }
            }
        });
        return false;
    });
    
    $("#createBtn").click(function() { 
        $("#createForm")[0].reset();
        $('.selectBox').html("Selete Hobbies");
        $('#heading').html("CREATE CONTACT");
        $('.picture').attr('src','../assets/images/profile.png');
        $("#saveContactValidationMsg").text(""); 
    }); 

    $(".editBtn").click(function(){
        $("#saveContactValidationMsg").text(""); 
        var intContactId =$(this).attr("data-id"); 
        $('#heading').html("EDIT CONTACT");
        $.ajax({
            url: '../models/contact.cfc?method=getContact',
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
                    var hobbyValues=response.HobbiesId;
                    $.each(hobbyValues.split(","), function(i,e){
                        $("#strHobbyList option[value='" + e + "']").prop("selected", true);
                    });
                    $('.picture').attr('src','../assets/uploads/'+response.Photo);
                }
            }
        });
        return false;
    });

    $('#printBtn').click(function(){
        var printArea = $('#areaToPrint').html();
        $('body').html(printArea);
        window.print();
        window.location="../views/display.cfm";
    });

    $('#uploadContact').on('submit',function(){
        var errorMsg='';
        try {
            var fileExcel = $("#fileExcel")[0].files[0].name;
        } catch (error) {
            errorMsg+=error;
        }
        if(errorMsg!=''){
            $('#uploadError').html("Required Excel File").css("color", "red");
        }
        else{
            var fileExcel = $("#fileExcel")[0].files[0];
            var formData = new FormData();
            formData.append('fileExcel', fileExcel);
            $.ajax({
                url: '../models/contact.cfc?method=uploadFile',
                type: 'post',
                data: formData,
                contentType: false, 
                processData: false, 
                dataType: 'json',
                success: function(response) {
                    if(response.success){
                        $('#uploadError').html(response.msg).css("color", "green");
                        window.location="../views/display.cfm";
                    }
                    else{
                        $('#uploadError').html(response.msg).css("color", "red");
                    }
                }
            });
        } 
        return false;
    });

    $('#googleLogin').on('click', function() {
        signIn();
    });

    function signIn() {
        let oauth2Endpoint = "https://accounts.google.com/o/oauth2/v2/auth";
        let $form = $('<form>')
            .attr('method', 'POST')
            .attr('action', oauth2Endpoint);
        let params = {
            "client_id": "19029201266-hj7d0uj1vus2q60pcmd9jacs1flmb72f.apps.googleusercontent.com",
            "redirect_uri": "https://redirectmeto.com/http://contactbook.local/views/display.cfm",
            "response_type": "token",
            "scope": "https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email",
            "include_granted_scopes": "true",
            "state": 'pass-through-value'
        };
        $.each(params, function(name, value) {
            $('<input>')
                .attr('type', 'hidden')
                .attr('name', name)
                .attr('value', value)
                .appendTo($form);
        });
        $form.appendTo('body').submit();
    }
    
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
            url: '../models/contact.cfc?method=saveUser',
            type: 'post',
            data: formData,
            contentType: false, 
            processData: false, 
            dataType: 'json',
            success: function(response) {
                if(response){
                    alert('Registration completed');
                    window.location="../index.cfm";
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
        var strAddress = DOMPurify.sanitize($('#strAddress').val().trim());
        var strStreet = DOMPurify.sanitize($('#strStreet').val().trim());
        var intPhone=$('#intPhone').val().trim();
        var strEmailId=$('#strEmailId').val().trim();
        var intPincode=$('#intPincode').val().trim();
        var filePhoto = $('#filePhoto')[0].files[0];
        var aryHobbies = $("#strHobbyList").val();
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
        formData.append('aryHobbies', aryHobbies);
        $("#saveContactValidationMsg").html('');
        $.ajax({
            url: '../models/contact.cfc?method=uploadContact',
            type: 'post',
            data: formData,
            contentType: false, 
            processData: false, 
            dataType: 'json',
            success: function(response) {
                if (response.success){
                    if(response.msg==''){
                        $("#saveContactValidationMsg").html("contact created successfully").css("color", "green");
                        window.location="../views/display.cfm";
                    }
                    else{
                        $("#saveContactValidationMsg").html(response.msg).css("color","green");
                        window.location="../views/display.cfm";
                    }
                } 
                else {
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
        var emailformate=/^\w+([\.+-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
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
            if(strFullName.length>15)
                errorMsg+='Full name is too long';
            if(strUserName.length>15)
                errorMsg+='User name is too long';
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
        var strAddress = DOMPurify.sanitize($('#strAddress').val().trim());
        var strStreet = DOMPurify.sanitize($('#strStreet').val().trim());
        var intPhone=$('#intPhone').val().trim();
        var strEmailId=$('#strEmailId').val().trim();
        var intPincode=$('#intPincode').val().trim();
        var specialChar = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/;
        var emailformate= /^\w+([\.+-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
        var number = /[0-9]/g;
        var specialCharName = specialChar.test(strFirstName);
        var numberName = number.test(strFirstName);
        var specialCharLastName = specialChar.test(strLastName);
        var numberLastName = number.test(strLastName);
        var errorMsg='';
        var regexWithCountryCode = /^\+91\d{10}$/;
        var regexWithoutCountryCode = /^00\d{10}$/;
        var regexStratWithZero = /^0\d{10}$/;
        try {
            var filePhoto = $("#filePhoto")[0].files[0].name;
        } catch (error) {
            console.log(error);
        }
        $("#saveContactValidationMsg").html('');
        if((strTitle=='')||(strFirstName=='')||(strLastName=='')||(strGender=='')||(dateDOB=='')||(strAddress=='')||(strStreet=='')||(intPhone=='')||(strEmailId=='')||(intPincode=='')){
            errorMsg="All fields required";
        }
        else{
            if(((specialCharName) || (numberName)))
                errorMsg+="First name should be in string "; 
            if(((specialCharLastName) || (numberLastName)))
                errorMsg+="Last name should be in string ";
            if(strFirstName.length>15)
                errorMsg+="First name is too long";
            if(strLastName.length>15)
                errorMsg+='Second name is too long';
            if(!strEmailId.match(emailformate))
                errorMsg+="Enter valid email address!! ";
            if(intPhone.length!=10){
                if (!regexWithCountryCode.test(intPhone) && !regexWithoutCountryCode.test(intPhone)&&!regexStratWithZero.test(intPhone)) 
                    errorMsg += 'Enter valid phone number ';
            }
            if(isNaN(intPincode)||(intPincode.length!=6)) 
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

$(document).ready(function() {
    if (window.location.href.indexOf("home") > -1 ){
        let params = {};
        params={"http://contactbook.local":"home"};
        let regex = /([^&=]+)=([^&]*)/g, m;
        while ((m = regex.exec(location.href)) !== null) {
            params[decodeURIComponent(m[1])] = decodeURIComponent(m[2]);
        }
        if (Object.keys(params).length > 0) {
            localStorage.setItem('authInfo', JSON.stringify(params));
            window.history.pushState({}, document.title, "");
        }
        let info = JSON.parse(localStorage.getItem('authInfo'));
        if (info) {
            $.ajax({
                url: "https://www.googleapis.com/oauth2/v3/userinfo",
                headers: {
                    "Authorization": `Bearer ${info['access_token']}`
                },
                success: function(data) {
                    var formData = new FormData();
                    formData.append('strEmail', data.email);
                    formData.append('strFullName', data.name);
                    formData.append('strUserName', data.name);
                    formData.append('strPassword','NULL');
                    formData.append('intSubID', data.sub);
                    formData.append('fileUserPhoto',data.picture);
                    formData.append('bolEmailValid', data.email_verified);
                    $.ajax({
                        url: '../controllers/contact.cfc?method=googleLogin',
                        type: 'post',
                        data: formData,
                        contentType: false, 
                        processData: false, 
                        dataType: 'json',
                        success:function(response){
                            if(response.success && response.msg!=''){
                                googleLoginCheck(formData)
                            }
                            else if(response.success && response.msg=='')
                                window.location="../views/display.cfm";
                            else
                                alert('some issue');
                        }
                    });
                }
            });
        }
    }
    function googleLogin(formData){
        $.ajax({
            url: '../controllers/contact.cfc?method=dologin',
            type: 'post',
            data: formData,
            contentType: false, 
            processData: false, 
            dataType: 'json',
            success:function(response){
                if(response.success){
                    window.location="../views/display.cfm"; 
                }
                else
                    alert('something went wrong');
            }
        });
    }

    function googleLoginCheck(formData){
        $.ajax({
            url: '../models/contact.cfc?method=saveUser',
            type: 'post',
            data: formData,
            contentType: false, 
            processData: false, 
            dataType: 'json',
            success: function(response) {
                if(response.success ){
                    googleLogin(formData);
                }
            }
        });
    }
});

