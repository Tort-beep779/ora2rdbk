/* Процедура */
CREATE PROCEDURE P_Few_Fors
AS
  DECLARE summa INTEGER = 0;
  DECLARE i_FOR1 INTEGER;
  DECLARE bound_i_FOR1 INTEGER;
  DECLARE i_FOR2 INTEGER;
BEGIN
  i_FOR1 = 1;
  bound_i_FOR1 = 3;
  WHILE (i_FOR1 <= bound_i_FOR1) DO
  BEGIN 
    summa = :summa + :i_FOR1;
    i_FOR1 = i_FOR1 + 1;
  END
  i_FOR1 = bound_i_FOR1;
  WHILE (1=1) DO
  BEGIN
    i_FOR2 = 1;
    IF (NOT (summa < 10)) THEN LEAVE; 
    summa = :summa + i_FOR2;
  END 
END; 

/* Функция */
CREATE FUNCTION F_Few_Fors
RETURNS INTEGER
AS
  DECLARE summa INTEGER = 0;
  DECLARE i_FOR1 INTEGER;
  DECLARE bound_i_FOR1 INTEGER;
  DECLARE i_FOR2 INTEGER;
BEGIN
  i_FOR1 = 1;
  bound_i_FOR1 = 3;
  WHILE (i_FOR1 <= bound_i_FOR1) DO
  BEGIN 
    summa = :summa + :i_FOR1;
    i_FOR1 = i_FOR1 + 1;
  END
  i_FOR1 = bound_i_FOR1;
  WHILE (1=1) DO
  BEGIN
    i_FOR2 = 1;
    IF (NOT (summa < 10)) THEN LEAVE; 
    summa = :summa + i_FOR2;
  END 
  RETURN summa;  -- 10
END; 

/* Пакет */
CREATE OR ALTER PACKAGE Pack_Few_Fors
AS BEGIN
   FUNCTION PF_Few_Fors 
   RETURNS INTEGER;
   PROCEDURE PP_Few_Fors; 
END; 

/* Тело пакета */
RECREATE PACKAGE BODY Pack_Few_Fors
AS BEGIN
   FUNCTION PF_Few_Fors
   RETURNS INTEGER
   AS
     DECLARE summa INTEGER = 0;
     DECLARE i_FOR1 INTEGER;
     DECLARE bound_i_FOR1 INTEGER;
     DECLARE i_FOR2 INTEGER;
   BEGIN
     i_FOR1 = 1;
     bound_i_FOR1 = 3;
     WHILE (i_FOR1 <= bound_i_FOR1) DO
     BEGIN 
       summa = :summa + :i_FOR1;
       i_FOR1 = i_FOR1 + 1;
     END
     i_FOR1 = bound_i_FOR1;
     WHILE (1=1) DO
     BEGIN
       i_FOR2 = 1;
       IF (NOT (summa < 10)) THEN LEAVE; 
       summa = :summa + i_FOR2;
     END 
     RETURN summa;
   END

   PROCEDURE PP_Few_Fors
   AS
     DECLARE summa INTEGER = 0;
     DECLARE i_FOR1 INTEGER;
     DECLARE bound_i_FOR1 INTEGER;
     DECLARE i_FOR2 INTEGER;
   BEGIN
     i_FOR1 = 1;
     bound_i_FOR1 = 3;
     WHILE (i_FOR1 <= bound_i_FOR1) DO
     BEGIN 
       summa = :summa + :i_FOR1;
       i_FOR1 = i_FOR1 + 1;
     END
     i_FOR1 = bound_i_FOR1;
     WHILE (1=1) DO
     BEGIN
       i_FOR2 = 1;
       IF (NOT (summa < 10)) THEN LEAVE; 
       summa = :summa + i_FOR2;
     END 
   END
END; 

/* Триггер DML */
CREATE OR ALTER TRIGGER T_Few_Fors
  AFTER INSERT 
  ON students
AS
  DECLARE summa INTEGER = 0;
  DECLARE i_FOR1 INTEGER;
  DECLARE bound_i_FOR1 INTEGER;
  DECLARE i_FOR2 INTEGER;
BEGIN
  i_FOR1 = 1;
  bound_i_FOR1 = 3;
  WHILE (i_FOR1 <= bound_i_FOR1) DO
  BEGIN 
    summa = :summa + :i_FOR1;
    i_FOR1 = i_FOR1 + 1;
  END
  i_FOR1 = bound_i_FOR1;
  WHILE (1=1) DO
  BEGIN
    i_FOR2 = 1;
    IF (NOT (summa < 10)) THEN LEAVE; 
    summa = :summa + i_FOR2;
  END 
END;

/* Анонимный блок */
EXECUTE BLOCK 
AS
  DECLARE summa INTEGER = 0;
  DECLARE i_FOR1 INTEGER;
  DECLARE bound_i_FOR1 INTEGER;
  DECLARE i_FOR2 INTEGER;
BEGIN
  i_FOR1 = 1;
  bound_i_FOR1 = 3;
  WHILE (i_FOR1 <= bound_i_FOR1) DO
  BEGIN 
    summa = :summa + :i_FOR1;
    i_FOR1 = i_FOR1 + 1;
  END
  i_FOR1 = bound_i_FOR1;
  WHILE (1=1) DO
  BEGIN
    i_FOR2 = 1;
    IF (NOT (summa < 10)) THEN LEAVE; 
    summa = :summa + i_FOR2;
  END -- 10
END; 