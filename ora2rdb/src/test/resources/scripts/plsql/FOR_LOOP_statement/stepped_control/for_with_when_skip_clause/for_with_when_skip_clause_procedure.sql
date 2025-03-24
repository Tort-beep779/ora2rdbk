CREATE PROCEDURE P_For_With_When
IS
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN 1..3 WHEN i != 2
  LOOP
      summa := summa + i;
  END LOOP;
END; 