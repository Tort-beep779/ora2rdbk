CREATE OR REPLACE TRIGGER T_From_Assoc_Array
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  summa PLS_INTEGER := 0;
  TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
  vec intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34);
BEGIN
  FOR i IN VALUES OF vec LOOP
      summa := summa + i;
   END LOOP;
END;