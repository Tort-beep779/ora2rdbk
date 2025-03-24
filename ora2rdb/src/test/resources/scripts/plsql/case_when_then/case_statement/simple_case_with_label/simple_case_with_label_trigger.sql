CREATE OR REPLACE TRIGGER simple_case_trigger
BEFORE INSERT ON employees
FOR EACH ROW
DECLARE
    grade CHAR(1);
    appraisal VARCHAR2(100);
BEGIN
    grade := 'A';
    <<label_name>>
    CASE grade
        WHEN 'A' THEN appraisal := 'Excellent';
        WHEN 'B' THEN appraisal := 'Very Good';
        WHEN 'C' THEN appraisal := 'Good';
    END CASE label_name;
END;