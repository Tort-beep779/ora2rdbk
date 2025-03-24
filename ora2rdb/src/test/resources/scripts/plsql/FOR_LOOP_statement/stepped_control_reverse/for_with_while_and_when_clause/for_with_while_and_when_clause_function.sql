CREATE FUNCTION F_For_With_While_and_When
RETURN PLS_INTEGER
IS
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN REVERSE 1..10 WHILE i > 5 WHEN i != 8 
  LOOP
      summa := summa + i;
  END LOOP;
  RETURN summa;  -- 32
END; 