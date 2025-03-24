DECLARE
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN REVERSE 1..3 WHEN i != 2
  LOOP
      summa := summa + i;  -- 4
  END LOOP;
END; 