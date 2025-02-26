CREATE OR ALTER PACKAGE Pack_Index_With_Label
AS BEGIN
   FUNCTION PF_Index_With_Label
   RETURNS INTEGER;
   PROCEDURE PP_Index_With_Label; 
END; 

RECREATE PACKAGE BODY Pack_Index_With_Label
AS BEGIN
   FUNCTION PF_Index_With_Label
   RETURNS INTEGER
   AS
     DECLARE summa INTEGER = 0;
     DECLARE i_FOR1 INTEGER;
   BEGIN
     forlabel:
     WHILE (1=1) DO
     BEGIN
       i_FOR1 = 1;
       summa = :summa + i_FOR1;
       LEAVE;
     END
     RETURN summa;
   END

   PROCEDURE PP_Index_With_Label
   AS
     DECLARE summa INTEGER = 0;
     DECLARE i_FOR1 INTEGER;
   BEGIN
     forlabel:
     WHILE (1=1) DO
     BEGIN
       i_FOR1 = 1;
       summa = :summa + i_FOR1;
       LEAVE;
     END
   END
END; 
