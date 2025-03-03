DECLARE
  summa PLS_INTEGER := 0;
BEGIN
  <<forlabel>>
  FOR i IN 1..3, REVERSE 1..3, 10..12 
  LOOP
      summa := summa + forlabel.i;  -- 45
  END LOOP forlabel;
END; 