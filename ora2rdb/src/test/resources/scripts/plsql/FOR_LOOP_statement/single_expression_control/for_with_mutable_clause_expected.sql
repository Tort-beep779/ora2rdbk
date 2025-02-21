/* Процедура */
CREATE PROCEDURE P_For_With_Mutable_Index
AS
  DECLARE summa INTEGER = 0;
  DECLARE i_FOR1 INTEGER;
BEGIN
  WHILE (1=1) DO
  BEGIN
    i_FOR1 = 1;
    i_FOR1 = i_FOR1 +1;
    summa = :summa + i_FOR1;
    if (summa > 10) then LEAVE; 
  END
END; 

/* Функция */
CREATE FUNCTION F_For_With_Mutable_Index
RETURNS INTEGER
AS
  DECLARE summa INTEGER = 0;
  DECLARE i_FOR1 INTEGER;
BEGIN
  WHILE (1=1) DO
  BEGIN
    i_FOR1 = 1;
    i_FOR1 = i_FOR1 +1;
    summa = :summa + i_FOR1;
    if (summa > 10) then LEAVE; 
  END
  RETURN summa;  -- 12
END; 

/* Пакет */
CREATE OR ALTER PACKAGE Pack_For_With_Mutable_Index
AS BEGIN
   FUNCTION PF_For_With_Mutable_Index
   RETURNS INTEGER;
   PROCEDURE PP_For_With_Mutable_Index; 
END; 

/* Тело пакета */
RECREATE PACKAGE BODY Pack_For_With_Mutable_Index
AS BEGIN
   FUNCTION PF_For_With_Mutable_Index
   RETURNS INTEGER
   AS
     DECLARE summa INTEGER = 0;
     DECLARE i_FOR1 INTEGER;
   BEGIN
     WHILE (1=1) DO
     BEGIN
       i_FOR1 = 1;
       i_FOR1 = i_FOR1 +1;
       summa = :summa + i_FOR1;
       if (summa > 10) then LEAVE; 
     END
     RETURN summa; 
   END 

   PROCEDURE PP_For_With_Mutable_Index
   AS
     DECLARE summa INTEGER = 0;
     DECLARE i_FOR1 INTEGER;
   BEGIN
     WHILE (1=1) DO
     BEGIN
       i_FOR1 = 1;
       i_FOR1 = i_FOR1 +1;
       summa = :summa + i_FOR1;
       if (summa > 10) then LEAVE; 
     END
   END
END; 

/* Триггер DML */
CREATE OR ALTER TRIGGER T_For_With_Mutable_Index
  AFTER INSERT 
  ON students
AS
  DECLARE summa INTEGER = 0;
  DECLARE i_FOR1 INTEGER;
BEGIN
  WHILE (1=1) DO
  BEGIN
    i_FOR1 = 1;
    i_FOR1 = i_FOR1 +1;
    summa = :summa + i_FOR1;
    if (summa > 10) then LEAVE; 
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
    i_FOR1 = i_FOR1 +1;
    summa = :summa + i_FOR1;
    if (summa > 10) then LEAVE; 
  END
END; 