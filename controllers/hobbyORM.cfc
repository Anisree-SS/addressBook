component persistent="true" table="hobbyTable" {
    property name="hobby" fieldtype="id";
    property name="contact" fieldtype="many-to-one" cfc="displayORM" fkcolumn="contactId";
}