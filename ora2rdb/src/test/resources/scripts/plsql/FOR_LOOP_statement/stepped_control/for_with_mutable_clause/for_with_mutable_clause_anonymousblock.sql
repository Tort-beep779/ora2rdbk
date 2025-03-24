DECLARE
  summa PLS_INTEGER := 0;
BEGIN
  FOR i MUTABLE IN 1..10 LOOP
      i := i+1;
      summa := summa + i;   -- 30
  END LOOP;
END; 