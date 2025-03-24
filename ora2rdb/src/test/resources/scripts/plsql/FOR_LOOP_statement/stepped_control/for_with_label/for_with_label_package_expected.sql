CREATE OR ALTER PACKAGE Pack_For_With_Label
AS BEGIN
   FUNCTION PF_For_With_Label
   RETURNS INTEGER;
   PROCEDURE PP_For_With_Label; 
END; 

RECREATE PACKAGE BODY Pack_For_With_Label
AS BEGIN
   FUNCTION PF_For_With_Label
   RETURNS INTEGER
   AS
     DECLARE summa INTEGER = 0;
     DECLARE i_FOR1 INTEGER;
     DECLARE bound_i_FOR1 INTEGER;
   BEGIN  
     i_FOR1 = 1;
     bound_i_FOR1 = 3;
     forlabel:
     WHILE (i_FOR1 <= bound_i_FOR1) DO
     BEGIN 
       summa = :summa + :i_FOR1;
       i_FOR1 = i_FOR1 + 1;
     END /*forlabel*/
     i_FOR1 = bound_i_FOR1;
     RETURN summa;
   END

   PROCEDURE PP_For_With_Label
   AS
     DECLARE summa INTEGER = 0;
     DECLARE i_FOR1 INTEGER;
     DECLARE bound_i_FOR1 INTEGER;
   BEGIN  
     i_FOR1 = 1;
     bound_i_FOR1 = 3;
     forlabel:
     WHILE (i_FOR1 <= bound_i_FOR1) DO
     BEGIN 
       summa = :summa + :i_FOR1;
       i_FOR1 = i_FOR1 + 1;
     END /*forlabel*/
     i_FOR1 = bound_i_FOR1;
   END 
END; 