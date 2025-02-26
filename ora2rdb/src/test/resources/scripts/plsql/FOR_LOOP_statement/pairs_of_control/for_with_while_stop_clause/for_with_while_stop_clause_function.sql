CREATE FUNCTION F_For_With_While
RETURN PLS_INTEGER
IS
   TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
   vec intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34);
   summa PLS_INTEGER := 0;
BEGIN
   FOR i, j IN PAIRS OF vec WHILE i < 20
   LOOP
      summa := summa + i;
   END LOOP;
  RETURN summa;  -- 1
END; 