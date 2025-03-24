CREATE PROCEDURE P_Multiple2
IS
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN 1..3 WHEN i < 3, i
  LOOP
      summa := summa + i;
  END LOOP;
END; 