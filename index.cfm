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
            include "/controllers/displayAction.cfm";  
            include "/views/header.cfm";
            include "/views/navbar.cfm";
            include "/views/display.cfm";
        break;
        case "view":
            include "/controllers/viewAction.cfm";  
            include "/views/header.cfm";
            include "/views/navbar.cfm";
        break;
    }
</cfscript>