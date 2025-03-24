CREATE FUNCTION F_Same_Name_Var
RETURN PLS_INTEGER
IS
  summa PLS_INTEGER := 0;
  i PLS_INTEGER;
BEGIN
  FOR i IN REVERSE 1..3 LOOP
      summa := summa + i;
  END LOOP;
  i := 10;
  summa := summa + i;
  RETURN summa;  -- 16
END; 