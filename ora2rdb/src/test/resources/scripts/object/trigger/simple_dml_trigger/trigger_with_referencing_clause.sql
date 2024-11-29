CREATE OR REPLACE TRIGGER Print_salary_changes
BEFORE UPDATE ON table_name
     REFERENCING new AS Newest
BEGIN
  :Newest.Field2 := TO_CHAR (:newest.field1);
END;