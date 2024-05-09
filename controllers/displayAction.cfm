<cfscript>
    variables.intContactId=0;
    variables.strTitle='';
    variables.strFirstName='';
    variables.strLastName='';
    variables.strGender='';
    variables.strAddress='';
    variables.filePhoto='';
    variables.strStreet='';
    variables.dateDOB='';
    variables.intPhone=0  ;
    variables.strEmailId='';
    variables.intPincode=0;
    if(structKeyExists(url,"intContactId")){
        variables.intContactId=url.intContactId;
        variables.qryGetRow=createObject("component","models.contact").getContact(intContactId=url.intContactId);
        variables.strTitle=variables.qryGetRow.Title;
        variables.strFirstName=variables.qryGetRow.FirstName;
        variables.strLastName=variables.qryGetRow.LastName;
        variables.strGender=variables.qryGetRow.Gender;
        variables.dateDOB=variables.qryGetRow.DOB;
        variables.filePhoto=variables.qryGetRow.Photo;
        variables.strAddress=variables.qryGetRow.Address;
        variables.strStreet=variables.qryGetRow.Street;
        variables.intPhone=variables.qryGetRow.Phone  ;
        variables.strEmailId=variables.qryGetRow.Email;
        variables.intPincode=variables.qryGetRow.Pincode;
    }
        
    variables.strHeading=structKeyExists(variables,"intContactId") AND variables.intContactId GT 0 ?"EDIT CONTACT":"CREATE CONTACT";
</cfscript>

