CREATE GLOBAL TEMPORARY TABLE VEC_Pack_Explicit_Index_PF_Explicit_Index (
    K INTEGER,
    VAL INTEGER,
    CONSTRAINT PK_VEC_Pack_Explicit_Index_PF_Explicit_Index PRIMARY KEY (K)
);

CREATE GLOBAL TEMPORARY TABLE VEC_Pack_Explicit_Index_PP_Explicit_Index (
    K INTEGER,
    VAL INTEGER,
    CONSTRAINT PK_VEC_Pack_Explicit_Index_PP_Explicit_Index PRIMARY KEY (K)
);

CREATE OR ALTER PACKAGE Pack_Explicit_Index
AS BEGIN
   FUNCTION PF_Explicit_Index
   RETURNS INTEGER;
   PROCEDURE PP_Explicit_Index; 
END; 

RECREATE PACKAGE BODY Pack_Explicit_Index
AS BEGIN
   FUNCTION PF_Explicit_Index
   RETURNS INTEGER
   AS
     /* TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER; */
     /* vec intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34); */
     DECLARE summa NUMERIC(5,1) = 0;
     DECLARE n_FOR1 NUMERIC(5,1);
   BEGIN
     UPDATE OR INSERT INTO VEC_Pack_Explicit_Index_PF_Explicit_Index VALUES (3, 10);
     UPDATE OR INSERT INTO VEC_Pack_Explicit_Index_PF_Explicit_Index VALUES (1, 11);
     UPDATE OR INSERT INTO VEC_Pack_Explicit_Index_PF_Explicit_Index VALUES (100, 34);
     FOR SELECT K FROM VEC_Pack_Explicit_Index_PF_Explicit_Index
     ORDER BY K ASC
     INTO :n_FOR1
     DO
     BEGIN
       summa = summa + n_FOR1; 
     END
     RETURN summa; 
   END

   PROCEDURE PP_Explicit_Index
   AS
     /* TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER; */
     /* vec intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34); */
     DECLARE summa NUMERIC(5,1) = 0;
     DECLARE n_FOR1 NUMERIC(5,1);
   BEGIN
     UPDATE OR INSERT INTO VEC_Pack_Explicit_Index_PP_Explicit_Index VALUES (3, 10);
     UPDATE OR INSERT INTO VEC_Pack_Explicit_Index_PP_Explicit_Index VALUES (1, 11);
     UPDATE OR INSERT INTO VEC_Pack_Explicit_Index_PP_Explicit_Index VALUES (100, 34);
     FOR SELECT K FROM VEC_Pack_Explicit_Index_PP_Explicit_Index
     ORDER BY K ASC
     INTO :n_FOR1
     DO
     BEGIN
       summa = summa + n_FOR1; 
     END
   END
END; 