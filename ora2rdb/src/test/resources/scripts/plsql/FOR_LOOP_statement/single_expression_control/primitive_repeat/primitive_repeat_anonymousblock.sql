DECLARE
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN REPEAT 1 
  LOOP
    if summa > 10 then exit; end if;
    summa := summa + i;
  END LOOP;
END;