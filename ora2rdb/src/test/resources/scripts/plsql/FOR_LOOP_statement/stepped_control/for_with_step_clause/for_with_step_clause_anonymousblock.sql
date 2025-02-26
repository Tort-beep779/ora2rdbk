DECLARE
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN 5..15 BY 5 
  LOOP
      summa := summa + i; -- 30
  END LOOP;
END; 