component {
    variables.modelObject=createObject("component","models.contact");
    remote any function doLogin(strUserName,strPassword) returnFormat="JSON" {
        local.error='';
        if(trim(len(strUserName)) EQ 0 OR trim(len(strPassword)) EQ 0)
            local.error='Required user name and password';
        if(len(local.error) EQ 0){
            local.strPassword=Hash(arguments.strPassword,"MD5");
            local.qryResult=variables.modelObject.doLogin(strUserName=strUserName,strPassword=strPassword);
            if (local.qryResult.recordCount) {
                session.userId= local.qryResult.userId;
                session.isLogin = true;
                session.fullName= local.qryResult.fullName;
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
                return {"success":true,"msg":"Registration completed successfully!!!"};
            else
                return {"success":false,"msg":"Something went wrong!!!"};
        }
        else{
            return local.strcheckUserResult;
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
        if((strEmailId EQ'')){
            error="All fields required";
        }
        if(len(local.error) EQ 0){
            local.booleanResult=variables.modelObject.checkContact(strEmailId=strEmailId);
            if (local.booleanResult) {
                return{"success":true};
            } 
            else {
                return {"success": false,"msg":"Email id already present"};
            }
        }
        else{
            return {"success":false,"msg":"#local.error#"};
        }
           
    }
}
