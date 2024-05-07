<cfscript>
    cfparam(name="url.action", default="login", pattern="");
    switch(lcase(url.action)){
        case "login":
            include "/views/header.cfm";
            include "/views/navbar.cfm";
            include "/views/loginPage.cfm";           
        break;
        case "register":
            include "/views/header.cfm";
            include "/views/navbar.cfm";
            include "/views/register.cfm";           
        break;
        case "display":
            include "/views/header.cfm";
            include "/views/navbar.cfm";
            include "/views/display.cfm";           
        break;
    }
</cfscript>