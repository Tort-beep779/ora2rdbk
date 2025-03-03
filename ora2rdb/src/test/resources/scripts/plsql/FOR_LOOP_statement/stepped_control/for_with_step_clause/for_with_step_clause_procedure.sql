CREATE PROCEDURE P_For_With_Step
IS
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN 5..15 BY 5 
  LOOP
    summa := summa + i;
  END LOOP;
END; 