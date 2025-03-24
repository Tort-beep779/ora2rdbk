CREATE FUNCTION F_Grade_meaning1 (degree INTEGER)
RETURN VARCHAR2
IS
  pass BOOLEAN := FALSE;
  res  CHAR(15) := '';
BEGIN
    IF degree > 10 THEN
      res := 'Good';
      pass := TRUE;
    END IF;
    IF (degree < 10) AND (degree >=5) THEN
      res := 'Low';
      pass := FALSE;
    END IF;
    IF (degree < 5) THEN
      res := 'Too low';
    END IF;
    RETURN res;
END;  
