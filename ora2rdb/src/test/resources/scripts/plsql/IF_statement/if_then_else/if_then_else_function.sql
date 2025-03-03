CREATE FUNCTION F_Grade_meaning2 (degree INTEGER)
RETURN VARCHAR2
IS
  pass BOOLEAN := FALSE;
  res  CHAR(15) := '';
BEGIN
    IF degree > 10 THEN
      res := 'Good';
      pass := TRUE;
    ELSE 
      res := 'Low';
      pass := FALSE;
    END IF;
    RETURN res;
END; 