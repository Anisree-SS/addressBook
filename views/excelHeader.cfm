<cfoutput>
    <cfset local.excelPlainQry = queryNew("Title,FirstName,LastName,Gender,DOB,Photo,Address,street,Email,pincode,Phone,Hobbies","varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar")> 
    <cfset excelFilePath = ExpandPath("./Plain_Template")>
    <cfspreadsheet action="write" filename="#excelFilePath#" query="local.excelPlainQry" sheetname="Plain_Template" overwrite = "true">
    <cfheader name="Content-Disposition" value="attachment; filename=Plain_Template.xlsx">
    <cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" file="#excelFilePath#" deleteFile="true">
</cfoutput>
</body>
</html>

