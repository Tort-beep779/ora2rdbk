CREATE TRIGGER searched_case_trigger
BEFORE INSERT ON employees
FOR EACH ROW
DECLARE
    grade CHAR(1);
    appraisal VARCHAR2(100);
BEGIN
    grade := 'A';
    <<label_name>>
    CASE
        WHEN grade = 'A' THEN appraisal := 'Excellent';
        WHEN grade = 'B' THEN appraisal := 'Very Good';
        WHEN grade = 'C' THEN appraisal := 'Good';
    END CASE label_name;
END;