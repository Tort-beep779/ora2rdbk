CREATE PROCEDURE P_Explicit_Index
IS
  summa NUMBER(5,1) := 0;
BEGIN
  FOR n NUMBER(5,1) IN 1.0 .. 3.0 BY 0.5 
  LOOP
      summa := summa + n;
  END LOOP;
END; 