DECLARE
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN REVERSE 1..3 WHILE i != 2
  LOOP
      summa := summa + i;  -- 3
  END LOOP;
END; 