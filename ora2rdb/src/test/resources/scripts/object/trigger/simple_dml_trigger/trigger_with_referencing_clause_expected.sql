-- Warning: this is a row trigger
CREATE  TRIGGER Print_salary_changes
    BEFORE UPDATE ON table_name
AS BEGIN
  	NEW.Field2 = CAST (NEW.field1 AS VARCHAR(32765));
END;