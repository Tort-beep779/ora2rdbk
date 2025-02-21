/* Процедура */
CREATE GLOBAL TEMPORARY TABLE VEC_P_For_With_Immut_Index (
    K INTEGER,
    VAL INTEGER,
    CONSTRAINT PK_VEC_P_For_With_Immut_Index PRIMARY KEY (K)
);

CREATE PROCEDURE P_For_With_Immut_Index
AS
  /* TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER; */
  /* vec intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34); */
  DECLARE summa INTEGER = 0;
  DECLARE i_FOR1 INTEGER;
BEGIN
  UPDATE OR INSERT INTO VEC_P_For_With_Immut_Index VALUES (3, 10);
  UPDATE OR INSERT INTO VEC_P_For_With_Immut_Index VALUES (1, 11);
  UPDATE OR INSERT INTO VEC_P_For_With_Immut_Index VALUES (100, 34);
  FOR SELECT VAL FROM VEC_P_For_With_Immut_Index
  ORDER BY K ASC
  INTO :i_FOR1
  DO
  BEGIN
    summa = summa + i_FOR1; 
  END
END; 

/* Функция */
CREATE GLOBAL TEMPORARY TABLE VEC_F_For_With_Immut_Index (
    K INTEGER,
    VAL INTEGER,
    CONSTRAINT PK_VEC_F_For_With_Immut_Index PRIMARY KEY (K)
);

CREATE FUNCTION F_For_With_Immut_Index
RETURNS INTEGER
AS
  /* TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER; */
  /* vec intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34); */
  DECLARE summa INTEGER = 0;
  DECLARE i_FOR1 INTEGER;
BEGIN
  UPDATE OR INSERT INTO VEC_F_For_With_Immut_Index VALUES (3, 10);
  UPDATE OR INSERT INTO VEC_F_For_With_Immut_Index VALUES (1, 11);
  UPDATE OR INSERT INTO VEC_F_For_With_Immut_Index VALUES (100, 34);
  FOR SELECT VAL FROM VEC_F_For_With_Immut_Index
  ORDER BY K ASC
  INTO :i_FOR1
  DO
  BEGIN
    summa = summa + i_FOR1; 
  END
  RETURN summa; -- 55
END; 

/* Пакет */
CREATE GLOBAL TEMPORARY TABLE VEC_Pack_For_With_Immut_Index_PF_For_With_Immut_Index (
    K INTEGER,
    VAL INTEGER,
    CONSTRAINT PK_VEC_Pack_For_With_Immut_Index_PF_For_With_Immut_Index PRIMARY KEY (K)
);

CREATE GLOBAL TEMPORARY TABLE VEC_Pack_For_With_Immut_Index_PP_For_With_Immut_Index (
    K INTEGER,
    VAL INTEGER,
    CONSTRAINT PK_VEC_Pack_For_With_Immut_Index_PP_For_With_Immut_Index PRIMARY KEY (K)
);

CREATE OR ALTER PACKAGE Pack_For_With_Immut_Index
AS BEGIN
   FUNCTION PF_For_With_Immut_Index
   RETURNS INTEGER;
   PROCEDURE PP_For_With_Immut_Index; 
END; 

/* Тело пакета */
RECREATE PACKAGE BODY Pack_For_With_Immut_Index
AS BEGIN
   FUNCTION PF_For_With_Immut_Index
   RETURNS INTEGER
   AS
     /* TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER; */
     /* vec intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34); */
     DECLARE summa INTEGER = 0;
     DECLARE i_FOR1 INTEGER;
   BEGIN
     UPDATE OR INSERT INTO VEC_Pack_For_With_Immut_Index_PF_For_With_Immut_Index VALUES (3, 10);
     UPDATE OR INSERT INTO VEC_Pack_For_With_Immut_Index_PF_For_With_Immut_Index VALUES (1, 11);
     UPDATE OR INSERT INTO VEC_Pack_For_With_Immut_Index_PF_For_With_Immut_Index VALUES (100, 34);
     FOR SELECT VAL FROM VEC_Pack_For_With_Immut_Index_PF_For_With_Immut_Index
     ORDER BY K ASC
     INTO :i_FOR1
     DO
     BEGIN
       summa = summa + i_FOR1; 
     END
     RETURN summa; -- 55
   END

   PROCEDURE PP_For_With_Immut_Index
   AS
     /* TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER; */
     /* vec intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34); */
     DECLARE summa INTEGER = 0;
     DECLARE i_FOR1 INTEGER;
   BEGIN
     UPDATE OR INSERT INTO VEC_Pack_For_With_Immut_Index_PP_For_With_Immut_Index VALUES (3, 10);
     UPDATE OR INSERT INTO VEC_Pack_For_With_Immut_Index_PP_For_With_Immut_Index VALUES (1, 11);
     UPDATE OR INSERT INTO VEC_Pack_For_With_Immut_Index_PP_For_With_Immut_Index VALUES (100, 34);
     FOR SELECT VAL FROM VEC_Pack_For_With_Immut_Index_PP_For_With_Immut_Index
     ORDER BY K ASC
     INTO :i_FOR1
     DO
     BEGIN
       summa = summa + i_FOR1; -- 55
     END
   END
END; 

/* Триггер DML */
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

/* Анонимный блок */
CREATE GLOBAL TEMPORARY TABLE VEC_AssArr_1 (
    K INTEGER,
    VAL INTEGER,
    CONSTRAINT PK_VEC_AssArr_1 PRIMARY KEY (K)
);

EXECUTE BLOCK 
AS
   /* TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER; */
   /* vec intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34); */
   DECLARE summa INTEGER = 0;
   DECLARE i_FOR1 INTEGER;
BEGIN
   UPDATE OR INSERT INTO VEC_AssArr_1 VALUES (3, 10);
   UPDATE OR INSERT INTO VEC_AssArr_1 VALUES (1, 11);
   UPDATE OR INSERT INTO VEC_AssArr_1 VALUES (100, 34);
   FOR SELECT VAL FROM VEC_AssArr_1
   ORDER BY K ASC
   INTO :i_FOR1
   DO
   BEGIN
     summa = summa + i_FOR1; -- 55
   END
END;