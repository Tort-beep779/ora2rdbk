CREATE OR REPLACE PACKAGE package_name
AS
    FUNCTION simple_case_function RETURN VARCHAR2;
END package_name;

CREATE OR REPLACE PACKAGE BODY package_name
AS
    FUNCTION simple_case_function
    RETURN VARCHAR2
    IS
        data_val NUMBER := 5;
        status VARCHAR2(20);
    BEGIN
        status :=
	        CASE data_val+5
		        WHEN 10 THEN 'outlier'
	        END;
        RETURN status;
    END;
END package_name;