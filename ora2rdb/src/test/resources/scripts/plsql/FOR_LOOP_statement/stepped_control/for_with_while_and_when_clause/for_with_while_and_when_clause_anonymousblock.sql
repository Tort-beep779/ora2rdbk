DECLARE
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN 1..10 WHILE i < 5 WHEN i != 2 
  LOOP
      summa := summa + i;  -- 8
  END LOOP;
END; 