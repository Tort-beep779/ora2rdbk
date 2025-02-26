CREATE OR REPLACE TRIGGER T_For_With_While_and_When
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN 1..10 WHILE i < 5 WHEN i != 3, REVERSE 1..10 WHILE i > 5 WHEN i != 8 
  LOOP
      summa := summa + i;
  END LOOP;
END;