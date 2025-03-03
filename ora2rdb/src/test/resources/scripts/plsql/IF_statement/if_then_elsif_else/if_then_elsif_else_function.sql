CREATE FUNCTION F_Grade_meaning5 (grade CHAR)
RETURN VARCHAR2
IS
  pass BOOLEAN := TRUE;
  res  CHAR(15) := '';
BEGIN
    IF grade = 'A' THEN
      res := 'Excellent';
      pass := TRUE;
    ELSIF (grade = 'B') THEN
      res := 'Very Good';
      pass := TRUE;
    ELSIF grade = 'C' THEN
      res := 'Good';
      pass := TRUE;
    ELSIF grade = 'D' THEN
      res := 'Fair';
      pass := FALSE;
    ELSIF grade = 'F' THEN
      res := 'Poor';
      pass := FALSE;
    ELSE
      res := 'Error';
      pass := FALSE;
    END IF;
    RETURN res;
END; 