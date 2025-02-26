CREATE OR REPLACE TRIGGER T_For_With_When
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN REVERSE 1..3 WHEN i != 2
  LOOP
      summa := summa + i;
  END LOOP;
END;