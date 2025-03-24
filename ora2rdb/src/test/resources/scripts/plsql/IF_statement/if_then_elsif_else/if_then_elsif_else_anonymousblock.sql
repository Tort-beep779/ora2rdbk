DECLARE
   pass BOOLEAN := TRUE;
   res  CHAR(15) := '';
   grade  CHAR(1) := 'B';
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
END; 