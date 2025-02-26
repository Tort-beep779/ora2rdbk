CREATE OR ALTER PACKAGE Pack_Expr_Bounds
AS BEGIN
   FUNCTION PF_Expr_Bounds
   RETURNS INTEGER;
   PROCEDURE PP_Expr_Bounds; 
END; 

RECREATE PACKAGE BODY Pack_Expr_Bounds
AS BEGIN
   FUNCTION PF_Expr_Bounds
   RETURNS INTEGER
   AS
     DECLARE summa INTEGER = 0;
     DECLARE power INTEGER;
     DECLARE i_FOR1 INTEGER;
     DECLARE bound_i_FOR1 INTEGER;  
   BEGIN
     power = 7;
     i_FOR1 = power+3;
     bound_i_FOR1 = power+5;
     WHILE (i_FOR1 <= bound_i_FOR1) DO
     BEGIN 
       summa = :summa + :i_FOR1;
       power = 10;
       i_FOR1 = i_FOR1 + 1;
     END
     i_FOR1 = bound_i_FOR1;
     RETURN summa;
   END

   PROCEDURE PP_Expr_Bounds
   AS
     DECLARE summa INTEGER = 0;
     DECLARE power INTEGER;
     DECLARE i_FOR1 INTEGER;
     DECLARE bound_i_FOR1 INTEGER;  
   BEGIN
     power = 7;
     i_FOR1 = power+3;
     bound_i_FOR1 = power+5;
     WHILE (i_FOR1 <= bound_i_FOR1) DO
     BEGIN 
       summa = :summa + :i_FOR1;
       power = 10;
       i_FOR1 = i_FOR1 + 1;
     END
     i_FOR1 = bound_i_FOR1;
   END
END; 