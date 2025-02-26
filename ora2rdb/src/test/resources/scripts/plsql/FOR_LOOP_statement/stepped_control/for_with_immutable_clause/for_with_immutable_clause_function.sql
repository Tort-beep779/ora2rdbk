CREATE FUNCTION F_For_With_Immutable_Index
RETURN PLS_INTEGER
IS
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IMMUTABLE IN 1..3 LOOP
      summa := summa + i;
  END LOOP;
  RETURN summa;  -- 6
END; 