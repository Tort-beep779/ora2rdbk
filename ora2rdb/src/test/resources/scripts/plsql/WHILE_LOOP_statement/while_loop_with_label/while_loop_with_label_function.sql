CREATE FUNCTION F_While_Label
RETURN VARCHAR2
IS
  done BOOLEAN := FALSE;
  res VARCHAR2(50) := '';
BEGIN
  <<loopA>>
  WHILE (NOT done) LOOP
    done := TRUE;
    res := 'Hello, world!';
  END LOOP loopA;
  RETURN res;
END; 