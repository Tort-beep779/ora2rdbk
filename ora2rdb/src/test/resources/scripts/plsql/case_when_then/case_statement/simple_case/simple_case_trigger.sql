CREATE OR REPLACE TRIGGER simple_case_trigger
BEFORE INSERT ON employees
FOR EACH ROW
DECLARE
    grade CHAR(1);
    appraisal VARCHAR2(100);
BEGIN
    grade := 'A';
    CASE grade
        WHEN 'A' THEN appraisal := 'Excellent';
        WHEN 'B' THEN appraisal := 'Very Good';
        WHEN 'C' THEN appraisal := 'Good';
    END CASE;
END;