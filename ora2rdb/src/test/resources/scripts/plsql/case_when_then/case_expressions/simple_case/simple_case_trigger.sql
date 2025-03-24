CREATE OR REPLACE TRIGGER simple_case_trigger
BEFORE INSERT ON employees
FOR EACH ROW
DECLARE
   grade CHAR(1);
   appraisal VARCHAR2(20);
BEGIN
   appraisal :=
      CASE grade
         WHEN NULL THEN 'No grade assigned'
         WHEN 'A' THEN 'Excellent'
      END;
END;