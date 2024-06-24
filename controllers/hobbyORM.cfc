component persistent="true" table="hobbyTable" {
    property name="ListID" fieldtype="id" generator="identity";
    property name="contactId" fieldtype="many-to-one" cfc="displayORM" fkcolumn="contactId";
    property name="hobbyId" cfc="hobbyListORM" fkcolumn="hobbyId";
}