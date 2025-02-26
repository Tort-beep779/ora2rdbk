CREATE FUNCTION F_For_With_Mutable_Index
RETURN PLS_INTEGER
IS
  summa PLS_INTEGER := 0;
BEGIN
  FOR i MUTABLE IN 1..10 LOOP
      i := i+1;
      summa := summa + i;
  END LOOP;
  RETURN summa;  -- 30
END; 