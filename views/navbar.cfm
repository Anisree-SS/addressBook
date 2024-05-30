<cfset variables.strLoginLink=''>
<cfset variables.strSignUpLink=''>
<cfset variables.strLogImg=session.isLogin?"logout":"login">
<cfset variables.strSignUpImg=session.isLogin?"":"person">
<cfset variables.strLoginLink= session.isLogin?"Logout":"Login">
<cfset variables.strSignUpLink= session.isLogin?"":"Sign Up">
<cfset variables.strLogoLink=session.isLogin?"?action=display":"?action=login">
<cfoutput>
<div class="navBar d-flex align-items-center justify-content-center col-12 ">
    <nav class="navbar-expand-lg flex-nowrap navbar-dark  px-3 px-sm-5 col-12 navBgColor">
        <div class="collapse navbar-collapse d-flex align-items-center justify-content-between">
            <div class="d-flex  gap-3">
                <a class="navbar-brand ponter">
                    <h5 class="text-light">
                        <a href='#variables.strLogoLink#' class="text-light">
                            <img src="./assets/images/contactBook.png" class="navContactImgLogo" alt="Address book logo">ADDRESS BOOK
                        </a>
                    </h5>
                </a>
            </div>
            <div class="d-flex gap-3">
                <div class="d-flex align-items-center">
                    <span class="material-symbols-outlined">#variables.strSignUpImg#</span>
                    <a class="nav-link text-light" href="?action=register">#variables.strSignUpLink#</a>
                </div>
                <div class="d-flex align-items-center">
                    <span class="material-symbols-outlined">#variables.strLogImg#</span>
                    <a class="nav-link text-light" href="./controllers/contact.cfc?method=doLogOut">#variables.strLoginLink#</a>
                </div>
            </div>
        </div>
    </nav>
</div>
</cfoutput>