CREATE FUNCTION F_Few_Fors
RETURN PLS_INTEGER
IS
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN REVERSE 1..3 LOOP
      summa := summa + i;
  END LOOP;
  FOR i IN REVERSE 50..53 LOOP
      summa := summa + i;
  END LOOP;
  RETURN summa;  -- 212
END; 