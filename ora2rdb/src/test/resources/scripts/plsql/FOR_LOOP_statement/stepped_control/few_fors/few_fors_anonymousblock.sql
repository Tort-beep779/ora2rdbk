DECLARE
  summa PLS_INTEGER := 0;  
BEGIN
  FOR i IN 1..3 LOOP
      summa := summa + i;
  END LOOP;
  FOR i IN 50..53 LOOP
      summa := summa + i;
  END LOOP;
END; 