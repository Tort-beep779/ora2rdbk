DECLARE
  summa NUMBER(5,1) := 0;
BEGIN
  FOR n NUMBER(5,1) IN REVERSE 1.0 .. 3.0 BY 0.5 
  LOOP
      summa := summa + n; -- 10
  END LOOP;
END; 