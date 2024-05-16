component {
    variables.modelObject=createObject("component","models.contact");
    remote any function doLogin(strUserName,strPassword) returnFormat="JSON" {
        local.error='';
        if(len(trim(strEmail)) EQ 0 OR len(trim(strPassword)) EQ 0)
            local.error='Required Email id and password';
        if(len(local.error) EQ 0){
            local.strPassword=Hash(arguments.strPassword,"MD5");
            local.qryResult=variables.modelObject.doLogin(strEmail=strEmail,strPassword=strPassword);
            if (local.qryResult.recordCount) {
                session.userId= local.qryResult.userId;
                session.isLogin = true;
                session.fullName= local.qryResult.fullName;
                session.profile=local.qryResult.Profile;
                return { "success": true };
            } 
            else 
                return { "success": false };
        }
        else{
            return {"success":false,"msg":local.error};
        }
    }   

    remote any function checkUser(strEmail,strUserName) returnFormat="JSON" {
        local.strcheckUserResult=variables.modelObject.checkUser(strEmail=strEmail,strUserName=strUserName);
        if(local.strcheckUserResult.success){
           return { "success": true };
        }else{
            return {"success":false,'msg':local.strcheckUserResult.msg}; 
        }
    }

    public void function checkLogin(){
        if(session.isLogin){
           cflocation(url="?action=display");
        }
    }

    remote any function doLogOut(){
        session.isLogin=false;
        cflocation(url="../?action=login");
    }

    remote any function checkContact() returnFormat='json'{
        local.error='';
        if((strEmailId=='')){
            error+="All fields required";
        }
        if(len(local.error) EQ 0){
            local.booleanResult=variables.modelObject.checkContact(intContactId=intContactId,strEmailId=strEmailId);
            if (local.booleanResult.success) {
                return {"success":true,'msg':''};
            } 
            else {
                return {"success": false,"msg":local.booleanResult.msg};
            }
        }
        else{
            return {"success":false,"msg":local.error};
        }
           
    }

    remote any function googleLogin() returnFormat='json'{
        if(bolGoogleEmailValid){
            local.strcheckUserResult=variables.modelObject.checkUser(strEmail=strGoogleMail,strUserName=strGoogleName);
            if(local.strcheckUserResult.success){
               
            }
        }
    }
}

