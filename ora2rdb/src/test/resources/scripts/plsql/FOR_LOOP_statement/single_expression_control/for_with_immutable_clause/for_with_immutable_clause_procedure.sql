CREATE PROCEDURE P_For_With_Immutable_Index
IS
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IMMUTABLE IN 1 LOOP
      summa := summa + i;
  END LOOP;
END; 