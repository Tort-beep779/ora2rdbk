CREATE OR REPLACE PACKAGE package_name
AS
    PROCEDURE simple_case_procedure;
END package_name;

CREATE OR REPLACE PACKAGE BODY package_name
AS
    PROCEDURE simple_case_procedure
    IS
        data_val NUMBER := 5;
        status VARCHAR2(20);
BEGIN
        status :=
	        CASE data_val+5
		        WHEN 10 THEN 'outlier'
	        END;
        END;
END package_name;