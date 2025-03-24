CREATE FUNCTION F_Explicit_Index
RETURN NUMBER
IS
  summa NUMBER(5,1) := 0;
BEGIN
  FOR n NUMBER(5,1) IN 1.0
  LOOP
      summa := summa + n;
  END LOOP;
  RETURN summa;  -- 10
END; 