CREATE FUNCTION F_For_With_Step
RETURN PLS_INTEGER
IS
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN 3..9 BY 3, REVERSE 5..15 BY 5 
  LOOP
      summa := summa + i;
  END LOOP;
  RETURN summa;  -- 48
END; 