DECLARE
  summa PLS_INTEGER := 0;
  power PLS_INTEGER;
BEGIN
  power := 7;
  FOR i IN power+3..power+5 
  LOOP
      summa := summa + i; --33
      power := 10;
  END LOOP;
END; 