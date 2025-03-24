CREATE PACKAGE PACKAGE_NAME
AS
    FUNCTION simple_case_function RETURN VARCHAR2;
END PACKAGE_NAME;

CREATE PACKAGE BODY PACKAGE_NAME
AS
    FUNCTION simple_case_function
    RETURN VARCHAR2
    IS
        grade CHAR(1);
        appraisal VARCHAR2(100);
BEGIN
        grade := 'A';
        CASE grade
            WHEN 'A' THEN appraisal := 'Excellent';
            WHEN 'B' THEN appraisal := 'Very Good';
            WHEN 'C' THEN appraisal := 'Good';
            ELSE appraisal := 'No such grade';
        END CASE;
        RETURN appraisal;
    END;
END PACKAGE_NAME;