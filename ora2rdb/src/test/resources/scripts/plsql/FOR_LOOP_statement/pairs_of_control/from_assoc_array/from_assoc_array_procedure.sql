CREATE PROCEDURE P_From_Assoc_Array
IS
  summa PLS_INTEGER := 0;
  TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
  vec intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34);
BEGIN
  FOR i, j IN PAIRS OF vec LOOP
      summa := summa + i;  
  END LOOP;
END; 