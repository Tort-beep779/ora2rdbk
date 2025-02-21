/* Процедура */
CREATE PROCEDURE P_Same_Name_Var
AS
  DECLARE summa INTEGER = 0;
  DECLARE i INTEGER;
  DECLARE i_FOR1 INTEGER;
BEGIN
  WHILE (1=1) DO
  BEGIN
    i_FOR1 = 1;
    summa = :summa + i_FOR1;
    LEAVE;
  END
  i = 10;
  summa = :summa + i;
END; 

/* Функция */
CREATE FUNCTION F_Same_Name_Var
RETURNS INTEGER
AS
  DECLARE summa INTEGER = 0;
  DECLARE i INTEGER;
  DECLARE i_FOR1 INTEGER;
BEGIN
  WHILE (1=1) DO
  BEGIN
    i_FOR1 = 1;
    summa = :summa + i_FOR1;
    LEAVE;
  END
  i = 10;
  summa = :summa + i;
  RETURN summa;  -- 11
END; 

/* Пакет */
CREATE OR ALTER PACKAGE Pack_Same_Name_Var
AS BEGIN
   FUNCTION PF_Same_Name_Var
   RETURNS INTEGER;
   PROCEDURE PP_Same_Name_Var; 
END; 

/* Тело пакета */
RECREATE PACKAGE BODY Pack_Same_Name_Var
AS BEGIN
   FUNCTION PF_Same_Name_Var
   RETURNS INTEGER
   AS
     DECLARE summa INTEGER = 0;
     DECLARE i INTEGER;
     DECLARE i_FOR1 INTEGER;
   BEGIN
     WHILE (1=1) DO
     BEGIN
        i_FOR1 = 1;
        summa = :summa + i_FOR1;
       LEAVE;
     END
     i = 10;
     summa = :summa + i;
     RETURN summa;
   END

   PROCEDURE PP_Same_Name_Var
   AS
     DECLARE summa INTEGER = 0;
     DECLARE i INTEGER;
     DECLARE i_FOR1 INTEGER;
   BEGIN
     WHILE (1=1) DO
     BEGIN
        i_FOR1 = 1;
        summa = :summa + i_FOR1;
       LEAVE;
     END
     i = 10;
     summa = :summa + i;
   END
END; 

/* Триггер DML */
CREATE OR ALTER TRIGGER T_Same_Name_Var
  AFTER INSERT 
  ON students
AS
  DECLARE summa INTEGER = 0;
  DECLARE i INTEGER;
  DECLARE i_FOR1 INTEGER;
BEGIN
  WHILE (1=1) DO
  BEGIN
    i_FOR1 = 1;
    summa = :summa + i_FOR1;
    LEAVE;
  END
  i = 10;
  summa = :summa + i;
END;

/* Анонимный блок */
EXECUTE BLOCK 
AS
  DECLARE summa INTEGER = 0;
  DECLARE i INTEGER;
  DECLARE i_FOR1 INTEGER;
BEGIN
  WHILE (1=1) DO
  BEGIN
    i_FOR1 = 1;
    summa = :summa + i_FOR1;
    LEAVE;
  END
  i = 10;
  summa = :summa + i;  -- 11
END; 