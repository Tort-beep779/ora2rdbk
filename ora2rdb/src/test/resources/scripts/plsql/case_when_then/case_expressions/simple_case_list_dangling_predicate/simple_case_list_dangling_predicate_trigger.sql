CREATE OR REPLACE TRIGGER simple_case_trigger
BEFORE INSERT ON employees
FOR EACH ROW
DECLARE
    data_val NUMBER := 35;
    status VARCHAR2(20);
BEGIN
    status :=
	    CASE data_val
		    WHEN < 0, > 50 THEN 'outlier'
		    WHEN < 20, > 30 THEN 'text'
	    END;
END;