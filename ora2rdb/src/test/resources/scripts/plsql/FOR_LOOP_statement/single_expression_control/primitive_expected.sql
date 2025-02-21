/* Процедура */
CREATE PROCEDURE P_Primitive
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
END; 

/* Функция */
CREATE FUNCTION F_Primitive
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
END; 

/* Пакет */
CREATE OR ALTER PACKAGE Pack_Primitive
AS BEGIN
   FUNCTION PF_Primitive 
   RETURNS INTEGER;
   PROCEDURE PP_Primitive; 
END; 

/* Тело пакета */
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

/* Триггер DML */
CREATE OR ALTER TRIGGER T_Primitive
  AFTER INSERT 
  ON students
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
END;

/* Анонимный блок */
EXECUTE BLOCK 
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
END; 