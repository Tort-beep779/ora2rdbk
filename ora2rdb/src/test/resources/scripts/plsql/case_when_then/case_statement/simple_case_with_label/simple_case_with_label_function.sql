CREATE FUNCTION simple_case_function
RETURN VARCHAR2
IS
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
    RETURN appraisal;
END;