CREATE PROCEDURE P_For_With_While
IS
  summa PLS_INTEGER := 0;
BEGIN
  FOR power IN 2, REPEAT power*2 WHILE power <= 64
  LOOP
      summa := summa + power;
  END LOOP;
END; 