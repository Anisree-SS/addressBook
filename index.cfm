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
        case "error":
            include "/views/header.cfm";
            include "/views/errorPage.cfm";
        break;
        case "pdfDownload":
            include "/views/header.cfm";
            include "/views/pdfDownload.cfm";
        break;
        case 'excelDownload':
            include '/views/header.cfm';
            include "/views/navbar.cfm";
            include '/views/excelDownload.cfm';
            include "/views/display.cfm";
        break;
        default :
            include "/views/header.cfm";
            include "/views/navbar.cfm";
            include "/views/logInPage.cfm"; 
        break;
    }
</cfscript>