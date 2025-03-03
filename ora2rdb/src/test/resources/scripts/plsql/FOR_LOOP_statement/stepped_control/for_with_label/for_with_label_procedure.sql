CREATE PROCEDURE P_For_With_Label
IS
  summa PLS_INTEGER := 0;
BEGIN
  <<forlabel>>
  FOR i IN 1..3
  LOOP
    summa := summa + i;
  END LOOP forlabel;
END; 