DECLARE
  grade CHAR(1);
  appraisal VARCHAR2(20);
BEGIN
  appraisal :=
    CASE
      WHEN grade IS NULL THEN 'No grade assigned'
      WHEN grade = 'B' THEN 'Very Good'
      ELSE 'No such grade'
    END;
END;