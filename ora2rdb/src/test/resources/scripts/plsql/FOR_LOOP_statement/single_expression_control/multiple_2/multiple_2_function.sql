CREATE FUNCTION F_Multiple2
RETURN PLS_INTEGER
IS
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN 1..3 WHEN i < 3, i
  LOOP
      summa := summa + i;
  END LOOP;
  RETURN summa; 
END; 