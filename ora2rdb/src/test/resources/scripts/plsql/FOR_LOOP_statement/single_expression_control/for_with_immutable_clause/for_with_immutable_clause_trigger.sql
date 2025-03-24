CREATE OR REPLACE TRIGGER T_For_With_Immutable_Index
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IMMUTABLE IN 1 LOOP
      summa := summa + i;
  END LOOP;
END; 