DECLARE
   pass BOOLEAN := FALSE;
   res  CHAR(15) := '';
   degree INTEGER:= 14;
BEGIN
    IF degree > 10 THEN
      res := 'Good';
      pass := TRUE;
    ELSE 
      res := 'Low';
      pass := FALSE;
    END IF;
END; 