CREATE OR REPLACE PACKAGE package_name
AS
   PROCEDURE simple_case_procedure;
END package_name;

CREATE OR REPLACE PACKAGE BODY package_name
AS
   PROCEDURE simple_case_procedure
   IS
      grade CHAR(1);
      appraisal VARCHAR2(20);
   BEGIN
        appraisal :=
          CASE grade
            WHEN NULL THEN 'No grade assigned'
            WHEN 'A' THEN 'Excellent'
          END;
   END;
END package_name;