CREATE FUNCTION F_Index_With_Label
RETURN PLS_INTEGER
IS
  summa PLS_INTEGER := 0;
BEGIN
  <<forlabel>>
  FOR i IN 1..3  
  LOOP
      summa := summa + forlabel.i;
  END LOOP forlabel;
  RETURN summa;  -- 6
END; 