DECLARE
    data_val NUMBER := 35;
    status VARCHAR2(20);
BEGIN
    status :=
	    CASE data_val
		    WHEN 10, 20, 30, 40, 50 THEN 'outlier'
	    END;
END;