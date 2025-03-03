CREATE OR REPLACE TRIGGER T_Index_With_Label
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  summa PLS_INTEGER := 0;
BEGIN
  <<forlabel>>
  FOR i IN 1..3, REVERSE 1..3, 10..12 
  LOOP
      summa := summa + forlabel.i;
  END LOOP forlabel;
END;