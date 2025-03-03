CREATE OR REPLACE TRIGGER T_For_With_While
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN 1..3 WHILE i != 2
  LOOP
      summa := summa + i;
  END LOOP;
END;