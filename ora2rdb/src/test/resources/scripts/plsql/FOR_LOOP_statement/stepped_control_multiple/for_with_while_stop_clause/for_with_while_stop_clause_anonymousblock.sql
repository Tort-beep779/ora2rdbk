DECLARE
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN 1..3 WHILE i != 2, REVERSE 1..3 WHILE i != 2
  LOOP
      summa := summa + i;  -- 4
  END LOOP;
END; 