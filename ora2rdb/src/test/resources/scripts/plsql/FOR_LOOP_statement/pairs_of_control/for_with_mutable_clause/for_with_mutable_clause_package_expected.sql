CREATE GLOBAL TEMPORARY TABLE VEC_Pack_Mutable_Index_PF_Mutable_Index (
    K INTEGER,
    VAL INTEGER,
    CONSTRAINT PK_VEC_Pack_Mutable_Index_PF_Mutable_Index PRIMARY KEY (K)
);

CREATE GLOBAL TEMPORARY TABLE VEC_Pack_Mutable_Index_PP_Mutable_Index (
    K INTEGER,
    VAL INTEGER,
    CONSTRAINT PK_VEC_Pack_Mutable_Index_PP_Mutable_Index PRIMARY KEY (K)
);

CREATE OR ALTER PACKAGE Pack_Mutable_Index
AS BEGIN
   FUNCTION PF_Mutable_Index
   RETURNS INTEGER;
   PROCEDURE PP_Mutable_Index; 
END; 

RECREATE PACKAGE BODY Pack_Mutable_Index
AS BEGIN
   FUNCTION PF_Mutable_Index
   RETURNS INTEGER
   AS
     /* TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER; */
     /* vec intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34); */
     DECLARE summa INTEGER = 0;
     DECLARE i_FOR1 INTEGER;
     DECLARE j_FOR1 INTEGER;
   BEGIN
     UPDATE OR INSERT INTO VEC_Pack_Mutable_Index_PF_Mutable_Index VALUES (3, 10);
     UPDATE OR INSERT INTO VEC_Pack_Mutable_Index_PF_Mutable_Index VALUES (1, 11);
     UPDATE OR INSERT INTO VEC_Pack_Mutable_Index_PF_Mutable_Index VALUES (100, 34);
     FOR SELECT K, VAL FROM VEC_Pack_Mutable_Index_PF_Mutable_Index
     ORDER BY K ASC
     INTO :i_FOR1, :j_FOR1
     DO
     BEGIN
       j_FOR1 = 100;
       summa = summa + i_FOR1; 
     END
     RETURN summa; -- 21
   END

   PROCEDURE PP_Mutable_Index
   AS
     /* TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER; */
     /* vec intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34); */
     DECLARE summa INTEGER = 0;
     DECLARE i_FOR1 INTEGER;
     DECLARE j_FOR1 INTEGER;
   BEGIN
     UPDATE OR INSERT INTO VEC_Pack_Mutable_Index_PP_Mutable_Index VALUES (3, 10);
     UPDATE OR INSERT INTO VEC_Pack_Mutable_Index_PP_Mutable_Index VALUES (1, 11);
     UPDATE OR INSERT INTO VEC_Pack_Mutable_Index_PP_Mutable_Index VALUES (100, 34);
     FOR SELECT K, VAL FROM VEC_Pack_Mutable_Index_PP_Mutable_Index
     ORDER BY K ASC
     INTO :i_FOR1, :j_FOR1
     DO
     BEGIN
       j_FOR1 = 100;
       summa = summa + i_FOR1; -- 21
     END
   END
END; 