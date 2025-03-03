CREATE PROCEDURE P_Explicit_Index
IS
  TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
  vec intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34);
  summa NUMBER(5,1) := 0;
BEGIN
  FOR n, m NUMBER(5,1) IN PAIRS OF vec
  LOOP
      summa := summa + m; 
  END LOOP;
END; 