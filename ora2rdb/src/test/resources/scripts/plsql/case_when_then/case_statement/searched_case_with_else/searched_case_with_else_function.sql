CREATE FUNCTION searched_case_function
RETURN VARCHAR2
IS
    grade CHAR(1);
    appraisal VARCHAR2(100);
BEGIN
  grade := 'A';
  CASE
    WHEN grade = 'A' THEN appraisal := 'Excellent';
    WHEN grade = 'B' THEN appraisal := 'Very Good';
    WHEN grade = 'C' THEN appraisal := 'Good';
    ELSE appraisal := 'No such grade';
  END CASE;
    RETURN appraisal;
END;