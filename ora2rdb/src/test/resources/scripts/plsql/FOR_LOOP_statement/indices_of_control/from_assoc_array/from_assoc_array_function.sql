CREATE FUNCTION F_From_Assoc_Array
RETURN PLS_INTEGER
IS
  summa PLS_INTEGER := 0;
  TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
  vec intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34);
BEGIN
  FOR i IN INDICES OF vec LOOP
      summa := summa + i;  
  END LOOP;
  RETURN summa; -- 55
END; 