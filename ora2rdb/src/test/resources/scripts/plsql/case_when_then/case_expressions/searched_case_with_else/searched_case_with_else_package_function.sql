CREATE OR REPLACE PACKAGE package_name
AS
   FUNCTION searched_case_function RETURN VARCHAR2;
END package_name;

CREATE OR REPLACE PACKAGE BODY package_name
AS
   FUNCTION searched_case_function
   RETURN VARCHAR2
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
      RETURN appraisal;
   END;
END package_name;