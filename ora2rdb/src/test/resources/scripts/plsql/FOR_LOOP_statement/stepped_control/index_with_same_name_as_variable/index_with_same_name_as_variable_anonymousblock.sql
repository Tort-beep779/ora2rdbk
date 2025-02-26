DECLARE
  summa PLS_INTEGER := 0;
  i PLS_INTEGER;
BEGIN
  FOR i IN 1..3 LOOP
      summa := summa + i;
  END LOOP;
  i := 10;
  summa := summa + i;  -- 16
END; 