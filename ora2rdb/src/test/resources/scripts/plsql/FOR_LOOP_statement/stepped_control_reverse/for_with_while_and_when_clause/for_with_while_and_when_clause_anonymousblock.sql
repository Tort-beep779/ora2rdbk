DECLARE
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN REVERSE 1..10 WHILE i > 5 WHEN i != 8
  LOOP
      summa := summa + i;  -- 32
  END LOOP;
END; 