CREATE OR REPLACE TRIGGER simple_case_trigger
BEFORE INSERT ON employees
FOR EACH ROW
DECLARE
    grade NUMBER;
    appraisal VARCHAR2(20);
BEGIN
    grade := 50;
	CASE grade
        WHEN 10, 20, 30, 40, 50 THEN appraisal := 'text';
	END;
END;