CREATE PACKAGE PACKAGE_NAME
AS
    PROCEDURE simple_case_procedure;
END PACKAGE_NAME;

CREATE PACKAGE BODY PACKAGE_NAME
AS
    PROCEDURE simple_case_procedure
    IS
        grade NUMBER;
        appraisal VARCHAR2(20);
    BEGIN
        grade := 50;
        CASE grade+25
            WHEN 100 THEN appraisal := 'Excellent';
            WHEN 75 THEN appraisal := 'Very Good';
            WHEN 50 THEN appraisal := 'Good';
        END CASE;
    END;
END PACKAGE_NAME;