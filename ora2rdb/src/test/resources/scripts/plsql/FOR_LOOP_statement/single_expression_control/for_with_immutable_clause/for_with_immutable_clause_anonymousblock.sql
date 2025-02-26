DECLARE
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IMMUTABLE IN 1 LOOP
      summa := summa + i;   
  END LOOP;
END; 