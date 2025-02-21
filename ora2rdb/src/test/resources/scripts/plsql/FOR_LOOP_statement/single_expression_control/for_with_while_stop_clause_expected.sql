/* Процедура */
CREATE PROCEDURE P_For_With_While
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
    summa = :summa + :power_FOR1;
  END
END; 

/* Функция */
CREATE FUNCTION F_For_With_While
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
    summa = :summa + :power_FOR1;
  END
  RETURN summa;  
END; 

/* Пакет */
CREATE OR ALTER PACKAGE Pack_For_With_While
AS BEGIN
   FUNCTION PF_For_With_While
   RETURNS INTEGER;
   PROCEDURE PP_For_With_While; 
END; 

/* Тело пакета */
RECREATE PACKAGE BODY Pack_For_With_While
AS BEGIN
   FUNCTION PF_For_With_While
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
       summa = :summa + :power_FOR1;
     END
     RETURN summa;
   END

   PROCEDURE PP_For_With_While
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
       summa = :summa + :power_FOR1;
     END
   END
END; 

/* Триггер DML */
CREATE OR ALTER TRIGGER T_For_With_While
  AFTER INSERT 
  ON students
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
    summa = :summa + :power_FOR1;
  END
END;

/* Анонимный блок */
EXECUTE BLOCK 
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
    summa = :summa + :power_FOR1;
  END
END; 