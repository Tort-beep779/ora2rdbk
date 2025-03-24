CREATE OR REPLACE TRIGGER simple_case_trigger
BEFORE INSERT ON employees
FOR EACH ROW
DECLARE
    grade NUMBER;
    appraisal VARCHAR2(20);
BEGIN
    grade := 50;
	CASE grade
        WHEN < 0, > 100 THEN appraisal := 'out of range';
	END;
END;