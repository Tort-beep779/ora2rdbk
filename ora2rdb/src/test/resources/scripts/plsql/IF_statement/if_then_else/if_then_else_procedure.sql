CREATE PROCEDURE P_Grade_meaning2 (degree INTEGER, res OUT CHAR)
IS
  pass BOOLEAN := FALSE;
BEGIN
    res := '';
    IF degree > 10 THEN
      res := 'Good';
      pass := TRUE;
    ELSE 
      res := 'Low';
      pass := FALSE;
    END IF;
END; 