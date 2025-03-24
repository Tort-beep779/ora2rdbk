DECLARE
    grade NUMBER;
    appraisal VARCHAR2(20);
BEGIN
    grade := 50;
	CASE grade
        WHEN < 0, > 100 THEN appraisal := 'out of range';
	END;
END;