<cfoutput>
    <cfif session.resultFile NEQ ''>
        <cfheader name="Content-Disposition" value="attachment; filename=Upload_Result.xlsx">
        <cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" file="#session.resultFile#" deleteFile="true">
    </cfif>
</cfoutput>
</body>
</html>


