CREATE OR REPLACE TRIGGER T_For_With_Mutable_Index
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  summa PLS_INTEGER := 0;
BEGIN
  FOR i MUTABLE IN REVERSE 1..10 LOOP
      i := i-1;
      summa := summa + i;
  END LOOP;
END; 