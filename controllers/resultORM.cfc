component persistent="true" table="resultsTable" {
    property name="ResultId" fieldtype="id" generator="identity";
    property name="Result";
    property name="contactId" fieldtype="many-to-one" cfc="displayORM" fkcolumn="contactId";
}