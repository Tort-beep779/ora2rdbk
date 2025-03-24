CREATE PROCEDURE simple_case_procedure
IS
    data_val NUMBER := 35;
    status VARCHAR2(20);
BEGIN
    status :=
	    CASE data_val
		    WHEN < 0, > 50 THEN 'outlier'
		    WHEN < 20, > 30 THEN 'text'
	    END;
END;