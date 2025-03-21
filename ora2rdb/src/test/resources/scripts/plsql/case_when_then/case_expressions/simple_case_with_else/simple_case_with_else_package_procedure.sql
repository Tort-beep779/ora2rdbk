CREATE OR REPLACE PACKAGE package_name
AS
    PROCEDURE simple_case_procedure;
END package_name;

CREATE OR REPLACE PACKAGE BODY package_name
AS
    PROCEDURE simple_case_procedure
    IS
        grade CHAR(1);
        appraisal VARCHAR2(100);
    BEGIN
        grade := 'A';
        CASE
            WHEN grade = 'A' THEN appraisal := 'Excellent';
            WHEN grade = 'B' THEN appraisal := 'Very Good';
            WHEN grade = 'C' THEN appraisal := 'Good';
        END CASE;
    END;
END package_name;