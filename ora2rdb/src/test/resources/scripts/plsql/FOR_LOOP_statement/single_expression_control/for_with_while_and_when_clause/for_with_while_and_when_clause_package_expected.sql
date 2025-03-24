CREATE OR ALTER PACKAGE Pack_For_With_While_and_When
AS BEGIN
   FUNCTION PF_For_With_While_and_When
   RETURNS INTEGER;
   PROCEDURE PP_For_With_While_and_When; 
END; 

RECREATE PACKAGE BODY Pack_For_With_While_and_When
AS BEGIN
   FUNCTION PF_For_With_While_and_When
   RETURNS INTEGER
   AS
     DECLARE summa INTEGER = 0;
     DECLARE power_FOR1 INTEGER;
   BEGIN
     WHILE (1=1) DO
     BEGIN 
       power_FOR1 = 2;
       summa = :summa + :power_FOR1;
       LEAVE;
     END
     WHILE (1=1) DO
     BEGIN 
       power_FOR1 = power_FOR1*2;
       IF (NOT (power_FOR1 <= 64)) THEN LEAVE;
       IF (NOT (MOD(power_FOR1, 32) = 0)) THEN CONTINUE;
       summa = :summa + :power_FOR1;
     END
     RETURN summa;
   END

   PROCEDURE PP_For_With_While_and_When
   AS
     DECLARE summa INTEGER = 0;
     DECLARE power_FOR1 INTEGER;
   BEGIN
     WHILE (1=1) DO
     BEGIN 
       power_FOR1 = 2;
       summa = :summa + :power_FOR1;
       LEAVE;
     END
     WHILE (1=1) DO
     BEGIN 
       power_FOR1 = power_FOR1*2;
       IF (NOT (power_FOR1 <= 64)) THEN LEAVE;
       IF (NOT (MOD(power_FOR1, 32) = 0)) THEN CONTINUE;
       summa = :summa + :power_FOR1;
     END
   END
END; 