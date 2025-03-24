CREATE OR REPLACE TRIGGER T_Explicit_Index
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
  vec intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34);
  summa NUMBER(5,1)  := 0;
BEGIN
  FOR n NUMBER(5,1) IN VALUES OF vec
  LOOP
      summa := summa + n; 
  END LOOP;
END;