CREATE OR REPLACE TRIGGER simple_case_trigger
BEFORE INSERT ON employees
FOR EACH ROW
DECLARE
    grade NUMBER;
    appraisal VARCHAR2(20);
BEGIN
    grade := 50;
    CASE grade+25
        WHEN 100 THEN appraisal := 'Excellent';
        WHEN 75 THEN appraisal := 'Very Good';
        WHEN 50 THEN appraisal := 'Good';
    END CASE;
END;
