CREATE FUNCTION F_For_With_When
RETURN PLS_INTEGER
IS
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN 1..3 WHEN i != 2
  LOOP
      summa := summa + i;
  END LOOP;
  RETURN summa;  -- 4
END; 