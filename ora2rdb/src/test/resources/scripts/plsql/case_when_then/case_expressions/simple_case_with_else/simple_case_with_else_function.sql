CREATE FUNCTION simple_case_function
RETURN VARCHAR2
IS
    grade CHAR(1);
    appraisal VARCHAR2(20);
BEGIN
    appraisal :=
        CASE grade
            WHEN NULL THEN 'No grade assigned'
            WHEN 'A' THEN 'Excellent'
            ELSE 'No such grade'
        END;
    RETURN appraisal;
END;