CREATE OR REPLACE PACKAGE package_name
AS
   PROCEDURE searched_case_procedure;
END package_name;

CREATE OR REPLACE PACKAGE BODY package_name
AS
   PROCEDURE searched_case_procedure
   IS
      grade CHAR(1);
      appraisal VARCHAR2(20);
   BEGIN
      appraisal :=
        CASE
          WHEN grade IS NULL THEN 'No grade assigned'
          WHEN grade = 'B' THEN 'Very Good'
          ELSE 'No such grade'
        END;
   END;
END package_name;