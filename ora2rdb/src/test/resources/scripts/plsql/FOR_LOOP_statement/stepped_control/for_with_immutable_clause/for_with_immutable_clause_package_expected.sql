CREATE OR ALTER PACKAGE Pack_For_With_Immutable_Index
AS BEGIN
   FUNCTION PF_For_With_Immutable_Index
   RETURNS INTEGER;
   PROCEDURE PP_For_With_Immutable_Index; 
END; 

RECREATE PACKAGE BODY Pack_For_With_Immutable_Index
AS BEGIN
   FUNCTION PF_For_With_Immutable_Index
   RETURNS INTEGER
   AS
     DECLARE summa INTEGER = 0;
     DECLARE i_FOR1 INTEGER;
     DECLARE bound_i_FOR1 INTEGER;
   BEGIN
     i_FOR1 = 1;
     bound_i_FOR1 = 3;
     WHILE (i_FOR1 <= bound_i_FOR1) DO
     BEGIN 
       summa = :summa + :i_FOR1;
       i_FOR1 = i_FOR1 + 1;
     END
     i_FOR1 = bound_i_FOR1;
     RETURN summa;  
   END

   PROCEDURE PP_For_With_Immutable_Index
   AS
     DECLARE summa INTEGER = 0;
     DECLARE i_FOR1 INTEGER;
     DECLARE bound_i_FOR1 INTEGER;
   BEGIN
     i_FOR1 = 1;
     bound_i_FOR1 = 3;
     WHILE (i_FOR1 <= bound_i_FOR1) DO
     BEGIN 
       summa = :summa + :i_FOR1;
       i_FOR1 = i_FOR1 + 1;
     END
     i_FOR1 = bound_i_FOR1;
   END
END; 