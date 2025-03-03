CREATE PROCEDURE P_For_With_While
IS
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN 1..3 WHILE i != 2
  LOOP
      summa := summa + i;
  END LOOP;
END; 