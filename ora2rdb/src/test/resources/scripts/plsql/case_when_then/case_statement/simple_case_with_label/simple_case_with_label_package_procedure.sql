CREATE PACKAGE PACKAGE_NAME
AS
    PROCEDURE simple_case_procedure;
END PACKAGE_NAME;

CREATE PACKAGE BODY PACKAGE_NAME
AS
    PROCEDURE simple_case_procedure
    IS
        grade CHAR(1);
        appraisal VARCHAR2(100);
BEGIN
        grade := 'A';
        <<label_name>>
        CASE grade
            WHEN 'A' THEN appraisal := 'Excellent';
            WHEN 'B' THEN appraisal := 'Very Good';
            WHEN 'C' THEN appraisal := 'Good';
        END CASE label_name;
    END;
END PACKAGE_NAME;