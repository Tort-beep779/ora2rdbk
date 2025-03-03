CREATE OR ALTER PACKAGE Pack_Primitive
AS BEGIN
   FUNCTION PF_Primitive 
   RETURNS INTEGER;
   PROCEDURE PP_Primitive; 
END; 

RECREATE PACKAGE BODY Pack_Primitive
AS BEGIN
   FUNCTION PF_Primitive
   RETURNS INTEGER
   AS
     DECLARE summa INTEGER = 0;
     DECLARE done CHAR(1) = 'F';
     DECLARE i_FOR1 INTEGER;
   BEGIN
     WHILE (1=1) DO
     BEGIN
       i_FOR1 = 1;
       summa = :summa + i_FOR1;
       done = 'T';
       LEAVE;
     END
     RETURN summa;
   END

   PROCEDURE PP_Primitive
   AS
     DECLARE summa INTEGER = 0;
     DECLARE done CHAR(1) = 'F';
     DECLARE i_FOR1 INTEGER;
   BEGIN
     WHILE (1=1) DO
     BEGIN
       i_FOR1 = 1;
       summa = :summa + i_FOR1;
       done = 'T';
       LEAVE;
     END
   END
END; 