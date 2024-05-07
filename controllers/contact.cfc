component {
    variables.modelObject=createObject("component","models.contact");
    remote any function doLogin(strUserName,strPassword) returnFormat="JSON" {
        local.error='';
        if(trim(len(strUserName)) EQ 0 || trim(len(strPassword)) EQ 0)
            local.error='Required user name and password';
        if(len(local.error) EQ 0){
            local.strPassword=Hash(arguments.strPassword,"MD5");
            local.qryResult=variables.modelObject.doLogin(strUserName=strUserName,strPassword=strPassword);
            if (local.qryResult.recordCount) {
                session.isLogin = true;
                return { "success": true };
            } 
            else 
                return { "success": false };
        }
        else{
            return {"success":false,"msg":"#local.error#"};
        }
    }   

    remote any function checkUser(strFullName,strEmail,strUserName,strPassword) returnFormat="JSON" {
        local.strcheckUserResult=variables.modelObject.checkUser(strEmail=strEmail,strUserName=strUserName);
        if(local.strcheckUserResult.success){
            local.strPassword=Hash(arguments.strPassword,"MD5");
            local.strInputResult=variables.modelObject.saveUser(strFullName=strFullName,strEmail=strEmail,strUserName=strUserName,strPassword=strPassword);
            if(local.strInputResult)
                return {"success":true,"msg":"Registration Completes"}
        }
        else{
            return local.strcheckUserResult;
        }
    }

}
