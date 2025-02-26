CREATE FUNCTION F_While
RETURN VARCHAR2
IS
  done BOOLEAN := FALSE;
  res VARCHAR2(50) := '';
BEGIN
  WHILE done LOOP
    res := 'This line does not print.';
  END LOOP;
  WHILE (NOT done) LOOP
    done := TRUE;
    res := 'Hello, world!';
  END LOOP;
  WHILE NOT done LOOP
    res := 'This line does not print.';
  END LOOP;
  RETURN res;
END; 