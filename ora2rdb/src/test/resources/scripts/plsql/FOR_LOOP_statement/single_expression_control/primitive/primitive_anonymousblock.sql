DECLARE
  summa PLS_INTEGER := 0;
  done CHAR(1) := 'F';
BEGIN
  FOR i IN 1 LOOP
      summa := summa + i;
      done := 'T';
  END LOOP;
END; 