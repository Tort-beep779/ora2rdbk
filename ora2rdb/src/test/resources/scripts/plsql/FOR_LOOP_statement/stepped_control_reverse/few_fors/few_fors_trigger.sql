CREATE OR REPLACE TRIGGER T_Few_Fors
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN REVERSE 1..3 LOOP
      summa := summa + i;
  END LOOP;
  FOR i IN REVERSE 50..53 LOOP
      summa := summa + i;
  END LOOP;
END;