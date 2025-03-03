CREATE GLOBAL TEMPORARY TABLE VEC_Pack_For_With_While_PF_For_With_While (
    K INTEGER,
    VAL INTEGER,
    CONSTRAINT PK_VEC_Pack_For_With_While_PF_For_With_While PRIMARY KEY (K)
);

CREATE GLOBAL TEMPORARY TABLE VEC_Pack_For_With_While_PP_For_With_While (
    K INTEGER,
    VAL INTEGER,
    CONSTRAINT PK_VEC_Pack_For_With_While_PP_For_With_While PRIMARY KEY (K)
);

CREATE OR ALTER PACKAGE Pack_For_With_While
AS BEGIN
   FUNCTION PF_For_With_While
   RETURNS INTEGER;
   PROCEDURE PP_For_With_While; 
END; 

RECREATE PACKAGE BODY Pack_For_With_While
AS BEGIN
   FUNCTION PF_For_With_While
   RETURNS INTEGER
   AS
     /* TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER; */
     /* vec intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34); */
     DECLARE summa INTEGER = 0;
     DECLARE i_FOR1 INTEGER;
   BEGIN
     UPDATE OR INSERT INTO VEC_Pack_For_With_While_PF_For_With_While VALUES (3, 10);
     UPDATE OR INSERT INTO VEC_Pack_For_With_While_PF_For_With_While VALUES (1, 11);
     UPDATE OR INSERT INTO VEC_Pack_For_With_While_PF_For_With_While VALUES (100, 34);
     FOR SELECT K FROM VEC_Pack_For_With_While_PF_For_With_While
     ORDER BY K ASC
     INTO :i_FOR1
     DO
     BEGIN
       IF (NOT(i_FOR1 < 20)) THEN LEAVE;
       summa = summa + i_FOR1; 
     END
     RETURN summa; -- 21
   END

   PROCEDURE PP_For_With_While
   AS
     /* TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER; */
     /* vec intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34); */
     DECLARE summa INTEGER = 0;
     DECLARE i_FOR1 INTEGER;
   BEGIN
     UPDATE OR INSERT INTO VEC_Pack_For_With_While_PP_For_With_While VALUES (3, 10);
     UPDATE OR INSERT INTO VEC_Pack_For_With_While_PP_For_With_While VALUES (1, 11);
     UPDATE OR INSERT INTO VEC_Pack_For_With_While_PP_For_With_While VALUES (100, 34);
     FOR SELECT K FROM VEC_Pack_For_With_While_PP_For_With_While
     ORDER BY K ASC
     INTO :i_FOR1
     DO
     BEGIN
       IF (NOT(i_FOR1 < 20)) THEN LEAVE;
       summa = summa + i_FOR1; -- 21
     END
   END
END; 