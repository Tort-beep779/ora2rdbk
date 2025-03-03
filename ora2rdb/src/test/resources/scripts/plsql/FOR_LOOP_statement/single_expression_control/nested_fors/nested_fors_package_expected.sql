CREATE OR ALTER PACKAGE Pack_Nested_Fors
AS BEGIN
   FUNCTION PF_Nested_Fors
   RETURNS INTEGER;
   PROCEDURE PP_Nested_Fors; 
END; 

RECREATE PACKAGE BODY Pack_Nested_Fors
AS BEGIN
   FUNCTION PF_Nested_Fors
   RETURNS INTEGER
   AS
     DECLARE summa INTEGER = 0;
     DECLARE i_FOR1 INTEGER;
     DECLARE n_FOR2 INTEGER;
   BEGIN
     WHILE (1=1) DO
     BEGIN
       i_FOR1 = 1;
       WHILE (1=1) DO
       BEGIN
         n_FOR2 = 1;
         summa = :summa + i_FOR1*n_FOR2;
         LEAVE;
       END
       WHILE (1=1) DO
       BEGIN
         n_FOR2 = n_FOR2*3;
         IF (NOT (n_FOR2 <= 9)) THEN LEAVE;
         summa = :summa + i_FOR1*n_FOR2;
       END
       LEAVE;
     END
     WHILE (1=1) DO
     BEGIN
       i_FOR1 = i_FOR1+2;
       IF (NOT (i_FOR1 < 9)) THEN LEAVE;
       WHILE (1=1) DO
       BEGIN
         n_FOR2 = 1;
         summa = :summa + i_FOR1*n_FOR2;
         LEAVE;
       END
       WHILE (1=1) DO
       BEGIN
         n_FOR2 = n_FOR2*3;
         IF (NOT (n_FOR2 <= 9)) THEN LEAVE;
         summa = :summa + i_FOR1*n_FOR2;
       END
     END
     RETURN summa;
   END

   PROCEDURE PP_Nested_Fors
   AS
     DECLARE summa INTEGER = 0;
     DECLARE i_FOR1 INTEGER;
     DECLARE n_FOR2 INTEGER;
   BEGIN
     WHILE (1=1) DO
     BEGIN
       i_FOR1 = 1;
       WHILE (1=1) DO
       BEGIN
         n_FOR2 = 1;
         summa = :summa + i_FOR1*n_FOR2;
         LEAVE;
       END
       WHILE (1=1) DO
       BEGIN
         n_FOR2 = n_FOR2*3;
         IF (NOT (n_FOR2 <= 9)) THEN LEAVE;
         summa = :summa + i_FOR1*n_FOR2;
       END
       LEAVE;
     END
     WHILE (1=1) DO
     BEGIN
       i_FOR1 = i_FOR1+2;
       IF (NOT (i_FOR1 < 9)) THEN LEAVE;
       WHILE (1=1) DO
       BEGIN
         n_FOR2 = 1;
         summa = :summa + i_FOR1*n_FOR2;
         LEAVE;
       END
       WHILE (1=1) DO
       BEGIN
         n_FOR2 = n_FOR2*3;
         IF (NOT (n_FOR2 <= 9)) THEN LEAVE;
         summa = :summa + i_FOR1*n_FOR2;
       END
     END
   END
END; 