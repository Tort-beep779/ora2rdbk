CREATE OR REPLACE PACKAGE package_name
AS
    FUNCTION simple_case_function RETURN VARCHAR2;
END package_name;

CREATE OR REPLACE PACKAGE BODY package_name
AS
    FUNCTION simple_case_function
    RETURN VARCHAR2
    IS
        grade NUMBER;
        appraisal VARCHAR2(20);
    BEGIN
        grade := 50;
	    CASE grade
            WHEN < 0, > 100 THEN appraisal := 'out of range';
	    END;
        RETURN status;
    END;
END package_name;