CREATE OR REPLACE TRIGGER T_For_With_Label
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  summa PLS_INTEGER := 0;
BEGIN
  <<forlabel>>
  FOR i IN 1..3 
  LOOP
      summa := summa + i;
  END LOOP forlabel;
END;