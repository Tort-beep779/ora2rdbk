DECLARE
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN 3..9 BY 3, REVERSE 5..15 BY 5 
  LOOP
      summa := summa + i; -- 48
  END LOOP;
END; 