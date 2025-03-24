CREATE FUNCTION F_Grade_meaning6 (grade CHAR)
RETURN VARCHAR2
IS
  pass BOOLEAN := TRUE;
  res  CHAR(15) := '';
BEGIN
    IF grade = 'A' THEN
      res := 'Excellent';
      pass := TRUE;
    ELSE
      IF (grade = 'B') THEN
        res := 'Very Good';
        pass := TRUE;
      ELSE
        IF grade = 'C' THEN
          res := 'Good';
          pass := TRUE;
        ELSE
          IF grade = 'D' THEN
            res := 'Fair';
            pass := FALSE;
          ELSE
            IF grade = 'F' THEN
              res := 'Poor';
              pass := FALSE;
            ELSE
              res := 'Error';
              pass := FALSE;
            END IF;
          END IF;
        END IF;
      END IF;
    END IF;
    RETURN res;
END; 