CREATE OR REPLACE TRIGGER T_Multiple2
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN 1..3 WHEN i < 3, i
  LOOP
      summa := summa + i;
  END LOOP;
END;