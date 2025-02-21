/* Процедура */
CREATE PROCEDURE P_Primitive_Repeat
AS
  DECLARE summa INTEGER = 0;
  DECLARE i_FOR1 INTEGER;
BEGIN
  WHILE (1=1) DO
  BEGIN
    i_FOR1 = 1;
    if (summa > 10) then LEAVE;
    summa = :summa + i_FOR1;
  END
END; 

/* Функция */
CREATE FUNCTION F_Primitive_Repeat
RETURNS INTEGER
AS
  DECLARE summa INTEGER = 0;
  DECLARE i_FOR1 INTEGER;
BEGIN
  WHILE (1=1) DO
  BEGIN
    i_FOR1 = 1;
    if (summa > 10) then LEAVE;
    summa = :summa + i_FOR1;
  END
  RETURN summa;
END; 

/* Пакет */
CREATE OR ALTER PACKAGE Pack_Primitive_Repeat
AS BEGIN
   FUNCTION PF_Primitive_Repeat 
   RETURNS INTEGER;
   PROCEDURE PP_Primitive_Repeat; 
END; 

/* Тело пакета */
RECREATE PACKAGE BODY Pack_Primitive_Repeat
AS BEGIN
   FUNCTION PF_Primitive_Repeat
   RETURNS INTEGER
   AS
     DECLARE summa INTEGER = 0;
     DECLARE i_FOR1 INTEGER;
   BEGIN
     WHILE (1=1) DO
     BEGIN
       i_FOR1 = 1;
       if (summa > 10) then LEAVE;
       summa = :summa + i_FOR1;
     END
     RETURN summa;
   END

   PROCEDURE PP_Primitive_Repeat
   AS
     DECLARE summa INTEGER = 0;
     DECLARE i_FOR1 INTEGER;
   BEGIN
     WHILE (1=1) DO
     BEGIN
       i_FOR1 = 1;
       if (summa > 10) then LEAVE;
       summa = :summa + i_FOR1;
     END
   END
END; 

/* Триггер DML */
CREATE OR ALTER TRIGGER T_Primitive_Repeat
  AFTER INSERT 
  ON students
AS
  DECLARE summa INTEGER = 0;
  DECLARE i_FOR1 INTEGER;
BEGIN
  WHILE (1=1) DO
  BEGIN
    i_FOR1 = 1;
    if (summa > 10) then LEAVE;
    summa = :summa + i_FOR1;
  END
END;

/* Анонимный блок */
EXECUTE BLOCK 
AS
  DECLARE summa INTEGER = 0;
  DECLARE i_FOR1 INTEGER;
BEGIN
  WHILE (1=1) DO
  BEGIN
    i_FOR1 = 1;
    if (summa > 10) then LEAVE;
    summa = :summa + i_FOR1;
  END
END;