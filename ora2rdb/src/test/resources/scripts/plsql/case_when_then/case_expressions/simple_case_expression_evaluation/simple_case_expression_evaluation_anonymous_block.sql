DECLARE
    data_val NUMBER := 5;
    status VARCHAR2(20);
BEGIN
    status :=
	    CASE data_val+5
		    WHEN 10 THEN 'outlier'
	    END;
END;