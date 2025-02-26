CREATE OR REPLACE TRIGGER T_Primitive
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  summa PLS_INTEGER := 0;
  done CHAR(1) := 'F';
BEGIN
  FOR i IN REVERSE 1..3 LOOP
      summa := summa + i;
      done := 'T';
  END LOOP;
END;