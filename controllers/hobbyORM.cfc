component persistent="true" table="hobbyTable" {
    property name="hobby" fieldtype="id";
    property name="contactId" fieldtype="many-to-one" cfc="displayORM" fkcolumn="contactId";
}