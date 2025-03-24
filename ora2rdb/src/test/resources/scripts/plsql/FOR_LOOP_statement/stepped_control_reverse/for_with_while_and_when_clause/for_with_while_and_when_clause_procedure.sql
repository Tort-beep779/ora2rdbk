CREATE PROCEDURE P_For_With_While_and_When
IS
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN REVERSE 1..10 WHILE i > 5 WHEN i != 8 
  LOOP
      summa := summa + i;
  END LOOP;
END; 