CREATE FUNCTION F_For_With_While
RETURN PLS_INTEGER
IS
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN 1..3 WHILE i != 2, REVERSE 1..3 WHILE i != 2
  LOOP
      summa := summa + i;
  END LOOP;
  RETURN summa;  -- 4
END; 