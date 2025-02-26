CREATE OR REPLACE TRIGGER T_While_Label
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  done BOOLEAN := FALSE;
  res  VARCHAR2(50) := '';
BEGIN
  <<loopA>>
  WHILE (NOT done) LOOP
    done := TRUE;
    res := 'Hello, world!';
  END LOOP loopA;
END T_While_Label;