CREATE PROCEDURE simple_case_procedure
IS
    data_val NUMBER := 35;
    status VARCHAR2(20);
BEGIN
    status :=
	    CASE data_val
		    WHEN < 0, > 50, 10, 20 THEN 'outlier'
	    END;
END;