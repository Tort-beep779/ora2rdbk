CREATE OR REPLACE TRIGGER T_Explicit_Index
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  summa NUMBER(5,1) := 0;
BEGIN
  FOR n NUMBER(5,1) IN 1.0
  LOOP
      summa := summa + n;
  END LOOP;
END;