/* Процедура */
CREATE PROCEDURE P_For_With_While
AS
  DECLARE summa INTEGER = 0;
  DECLARE i_FOR1 INTEGER;
  DECLARE bound_i_FOR1 INTEGER;
BEGIN
  i_FOR1 = 1;
  bound_i_FOR1 = 3;
  WHILE (i_FOR1 <= bound_i_FOR1) DO
  BEGIN 
    IF (NOT(i_FOR1 != 2)) THEN LEAVE;
    summa = :summa + :i_FOR1;
    i_FOR1 = i_FOR1 + 1;
  END
  i_FOR1 = bound_i_FOR1;
END; 

/* Функция */
CREATE FUNCTION F_For_With_While
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
    IF (NOT(i_FOR1 != 2)) THEN LEAVE;
    summa = :summa + :i_FOR1;
    i_FOR1 = i_FOR1 + 1;
  END
  i_FOR1 = bound_i_FOR1;
  RETURN summa;  -- 1
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
     DECLARE i_FOR1 INTEGER;
     DECLARE bound_i_FOR1 INTEGER;
   BEGIN
     i_FOR1 = 1;
     bound_i_FOR1 = 3;
     WHILE (i_FOR1 <= bound_i_FOR1) DO
     BEGIN 
       IF (NOT(i_FOR1 != 2)) THEN LEAVE;
       summa = :summa + :i_FOR1;
       i_FOR1 = i_FOR1 + 1;
     END
     i_FOR1 = bound_i_FOR1;
     RETURN summa;
   END

   PROCEDURE PP_For_With_While
   AS
     DECLARE summa INTEGER = 0;
     DECLARE i_FOR1 INTEGER;
     DECLARE bound_i_FOR1 INTEGER;
   BEGIN
     i_FOR1 = 1;
     bound_i_FOR1 = 3;
     WHILE (i_FOR1 <= bound_i_FOR1) DO
     BEGIN 
       IF (NOT(i_FOR1 != 2)) THEN LEAVE;
       summa = :summa + :i_FOR1;
       i_FOR1 = i_FOR1 + 1;
     END
     i_FOR1 = bound_i_FOR1;
   END
END; 

/* Триггер DML */
CREATE OR ALTER TRIGGER T_For_With_While
  AFTER INSERT 
  ON students
AS
  DECLARE summa INTEGER = 0;
  DECLARE i_FOR1 INTEGER;
  DECLARE bound_i_FOR1 INTEGER;
BEGIN
  i_FOR1 = 1;
  bound_i_FOR1 = 3;
  WHILE (i_FOR1 <= bound_i_FOR1) DO
  BEGIN 
    IF (NOT(i_FOR1 != 2)) THEN LEAVE;
    summa = :summa + :i_FOR1;
    i_FOR1 = i_FOR1 + 1;
  END
  i_FOR1 = bound_i_FOR1;
END;

/* Анонимный блок */
EXECUTE BLOCK 
AS
  DECLARE summa INTEGER = 0;
  DECLARE i_FOR1 INTEGER;
  DECLARE bound_i_FOR1 INTEGER;
BEGIN
  i_FOR1 = 1;
  bound_i_FOR1 = 3;
  WHILE (i_FOR1 <= bound_i_FOR1) DO
  BEGIN 
    IF (NOT(i_FOR1 != 2)) THEN LEAVE;
    summa = :summa + :i_FOR1;
    i_FOR1 = i_FOR1 + 1;
  END
  i_FOR1 = bound_i_FOR1;
END; 