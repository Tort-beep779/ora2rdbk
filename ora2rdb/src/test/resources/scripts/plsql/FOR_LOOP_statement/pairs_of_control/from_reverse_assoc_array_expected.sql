/* Процедура */
CREATE GLOBAL TEMPORARY TABLE VEC_P_From_Reverse_AA (
    K INTEGER,
    VAL INTEGER,
    CONSTRAINT PK_VEC_P_From_Reverse_AA PRIMARY KEY (K)
);

CREATE PROCEDURE P_From_Reverse_AA
AS
  /* TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER; */
  /* vec intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34); */
  DECLARE summa INTEGER = 0;
  DECLARE i_FOR1 INTEGER;
  DECLARE j_FOR1 INTEGER;
BEGIN
  UPDATE OR INSERT INTO VEC_P_From_Reverse_AA VALUES (3, 10);
  UPDATE OR INSERT INTO VEC_P_From_Reverse_AA VALUES (1, 11);
  UPDATE OR INSERT INTO VEC_P_From_Reverse_AA VALUES (100, 34);
  FOR SELECT K, VAL FROM VEC_P_From_Reverse_AA
  ORDER BY K DESC
  INTO :i_FOR1, :j_FOR1
  DO
  BEGIN
    summa = summa + i_FOR1; 
  END
END; 

/* Функция */
CREATE GLOBAL TEMPORARY TABLE VEC_F_From_Reverse_AA (
    K INTEGER,
    VAL INTEGER,
    CONSTRAINT PK_VEC_F_From_Reverse_AA PRIMARY KEY (K)
);

CREATE FUNCTION F_From_Reverse_AA
RETURNS INTEGER
AS
  /* TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER; */
  /* vec intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34); */
  DECLARE summa INTEGER = 0;
  DECLARE i_FOR1 INTEGER;
  DECLARE j_FOR1 INTEGER;
BEGIN
  UPDATE OR INSERT INTO VEC_F_From_Reverse_AA VALUES (3, 10);
  UPDATE OR INSERT INTO VEC_F_From_Reverse_AA VALUES (1, 11);
  UPDATE OR INSERT INTO VEC_F_From_Reverse_AA VALUES (100, 34);
  FOR SELECT K, VAL FROM VEC_F_From_Reverse_AA
  ORDER BY K DESC
  INTO :i_FOR1, :j_FOR1
  DO
  BEGIN
    summa = summa + i_FOR1; 
  END
  RETURN summa; 
END; 

/* Пакет */
CREATE GLOBAL TEMPORARY TABLE VEC_Pack_From_Reverse_AA_PF_From_Reverse_AA (
    K INTEGER,
    VAL INTEGER,
    CONSTRAINT PK_VEC_Pack_From_Reverse_AA_PF_From_Reverse_AA PRIMARY KEY (K)
);

CREATE GLOBAL TEMPORARY TABLE VEC_Pack_From_Reverse_AA_PP_From_Reverse_AA (
    K INTEGER,
    VAL INTEGER,
    CONSTRAINT PK_VEC_Pack_From_Reverse_AA_PP_From_Reverse_AA PRIMARY KEY (K)
);

CREATE OR ALTER PACKAGE Pack_From_Reverse_AA
AS BEGIN
   FUNCTION PF_From_Reverse_AA
   RETURNS INTEGER;
   PROCEDURE PP_From_Reverse_AA; 
END; 

/* Тело пакета */
RECREATE PACKAGE BODY Pack_From_Reverse_AA
AS BEGIN
   FUNCTION PF_From_Reverse_AA
   RETURNS INTEGER
   AS
     /* TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER; */
     /* vec intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34); */
     DECLARE summa INTEGER = 0;
     DECLARE i_FOR1 INTEGER;
     DECLARE j_FOR1 INTEGER;
   BEGIN
     UPDATE OR INSERT INTO VEC_Pack_From_Reverse_AA_PF_From_Reverse_AA VALUES (3, 10);
     UPDATE OR INSERT INTO VEC_Pack_From_Reverse_AA_PF_From_Reverse_AA VALUES (1, 11);
     UPDATE OR INSERT INTO VEC_Pack_From_Reverse_AA_PF_From_Reverse_AA VALUES (100, 34);
     FOR SELECT K, VAL FROM VEC_Pack_From_Reverse_AA_PF_From_Reverse_AA
     ORDER BY K DESC
     INTO :i_FOR1, :j_FOR1
     DO
     BEGIN
       summa = summa + i_FOR1; 
     END
     RETURN summa; 
   END

   PROCEDURE PP_From_Reverse_AA
   AS
     /* TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER; */
     /* vec intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34); */
     DECLARE summa INTEGER = 0;
     DECLARE i_FOR1 INTEGER;
     DECLARE j_FOR1 INTEGER;
   BEGIN
     UPDATE OR INSERT INTO VEC_Pack_From_Reverse_AA_PP_From_Reverse_AA VALUES (3, 10);
     UPDATE OR INSERT INTO VEC_Pack_From_Reverse_AA_PP_From_Reverse_AA VALUES (1, 11);
     UPDATE OR INSERT INTO VEC_Pack_From_Reverse_AA_PP_From_Reverse_AA VALUES (100, 34);
     FOR SELECT K, VAL FROM VEC_Pack_From_Reverse_AA_PP_From_Reverse_AA
     ORDER BY K DESC
     INTO :i_FOR1, :j_FOR1
     DO
     BEGIN
       summa = summa + i_FOR1; 
     END
   END
END; 

/* Триггер DML */
CREATE GLOBAL TEMPORARY TABLE VEC_T_From_Reverse_AA (
    K INTEGER,
    VAL INTEGER,
    CONSTRAINT PK_VEC_T_From_Reverse_AA PRIMARY KEY (K)
);

CREATE OR ALTER TRIGGER T_From_Reverse_AA
  AFTER INSERT 
  ON students
AS
  /* TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER; */
  /* vec intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34); */
  DECLARE summa INTEGER = 0;
  DECLARE i_FOR1 INTEGER;
  DECLARE j_FOR1 INTEGER;
BEGIN
  UPDATE OR INSERT INTO VEC_T_From_Reverse_AA VALUES (3, 10);
  UPDATE OR INSERT INTO VEC_T_From_Reverse_AA VALUES (1, 11);
  UPDATE OR INSERT INTO VEC_T_From_Reverse_AA VALUES (100, 34);
  FOR SELECT K, VAL FROM VEC_T_From_Reverse_AA
  ORDER BY K DESC
  INTO :i_FOR1, :j_FOR1
  DO
  BEGIN
    summa = summa + i_FOR1; 
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
   DECLARE j_FOR1 INTEGER;
BEGIN
   UPDATE OR INSERT INTO VEC_AssArr_1 VALUES (3, 10);
   UPDATE OR INSERT INTO VEC_AssArr_1 VALUES (1, 11);
   UPDATE OR INSERT INTO VEC_AssArr_1 VALUES (100, 34);
   FOR SELECT K, VAL FROM VEC_AssArr_1
   ORDER BY K DESC
   INTO :i_FOR1, :j_FOR1
   DO
   BEGIN
     summa = summa + i_FOR1; 
   END
END;

