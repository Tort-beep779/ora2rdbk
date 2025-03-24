DECLARE
   pass BOOLEAN := FALSE;
   res  CHAR(15) := '';
   degree INTEGER := 14;
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
END; 