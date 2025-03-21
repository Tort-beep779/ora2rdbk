DECLARE
    grade CHAR(1);
    appraisal VARCHAR2(20);
BEGIN
    appraisal :=
        CASE grade
            WHEN NULL THEN 'No grade assigned'
            WHEN 'A' THEN 'Excellent'
            ELSE 'No such grade'
        END;
END;