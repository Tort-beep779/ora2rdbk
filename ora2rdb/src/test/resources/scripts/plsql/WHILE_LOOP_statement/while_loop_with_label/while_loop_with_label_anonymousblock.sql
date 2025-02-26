DECLARE
  done BOOLEAN := FALSE;
  res  VARCHAR2(50) := '';
BEGIN
  <<loopA>>
  WHILE (NOT done) LOOP
    done := TRUE;
    res := 'Hello, world!';
  END LOOP loopA;
END; 