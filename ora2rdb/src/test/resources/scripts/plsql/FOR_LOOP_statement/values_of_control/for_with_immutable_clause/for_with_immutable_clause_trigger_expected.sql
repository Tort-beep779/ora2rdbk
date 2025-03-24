CREATE GLOBAL TEMPORARY TABLE VEC_T_For_With_Immut_Index (
    K INTEGER,
    VAL INTEGER,
    CONSTRAINT PK_VEC_T_For_With_Immut_Index PRIMARY KEY (K)
);

CREATE OR ALTER TRIGGER T_For_With_Immut_Index
  AFTER INSERT 
  ON students
AS
  /* TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER; */
  /* vec intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34); */
  DECLARE summa INTEGER = 0;
  DECLARE i_FOR1 INTEGER;
BEGIN
  UPDATE OR INSERT INTO VEC_T_For_With_Immut_Index VALUES (3, 10);
  UPDATE OR INSERT INTO VEC_T_For_With_Immut_Index VALUES (1, 11);
  UPDATE OR INSERT INTO VEC_T_For_With_Immut_Index VALUES (100, 34);
  FOR SELECT VAL FROM VEC_T_For_With_Immut_Index
  ORDER BY K ASC
  INTO :i_FOR1
  DO
  BEGIN
    summa = summa + i_FOR1; -- 55
  END
END;