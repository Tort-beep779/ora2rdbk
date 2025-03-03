CREATE OR REPLACE TRIGGER T_While
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  done BOOLEAN := FALSE;
  res  VARCHAR2(50) := '';
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
END T_While;