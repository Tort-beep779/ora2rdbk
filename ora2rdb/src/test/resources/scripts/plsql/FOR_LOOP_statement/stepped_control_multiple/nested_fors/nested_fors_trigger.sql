CREATE OR REPLACE TRIGGER T_Nested_Fors
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN 1..3, REVERSE 1..3 LOOP
    FOR n IN 1..3, REVERSE 1..3 LOOP
      summa := summa + i*n; 
    END LOOP;
  END LOOP;
END;