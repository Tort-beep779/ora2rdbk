CREATE FUNCTION F_Explicit_Index
RETURN NUMBER
IS
  summa NUMBER(5,1) := 0;
BEGIN
  FOR n NUMBER(5,1) IN REVERSE 1.0 .. 3.0 BY 0.5 
  LOOP
      summa := summa + n;
  END LOOP;
  RETURN summa;  -- 10
END; 