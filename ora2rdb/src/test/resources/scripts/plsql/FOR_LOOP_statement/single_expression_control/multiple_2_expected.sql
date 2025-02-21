/* Процедура */
CREATE PROCEDURE P_Multiple2
AS
  DECLARE summa INTEGER = 0;
  DECLARE i_FOR1 INTEGER;
  DECLARE bound_i_FOR1 INTEGER;
BEGIN
  i_FOR1 = 1;
  bound_i_FOR1 = 3;
  WHILE (i_FOR1 <= bound_i_FOR1) DO
  BEGIN 
    IF (NOT (i_FOR1 < 3)) THEN                       
    BEGIN 
      i_FOR1 = i_FOR1 + 1; 
      CONTINUE;
    END
      summa = :summa + :i_FOR1;
      i_FOR1 = i_FOR1 + 1;
  END
  i_FOR1 = bound_i_FOR1;
  WHILE (1=1) DO
  BEGIN
    i_FOR1 = i_FOR1;
    summa = :summa + i_FOR1;
    LEAVE;
  END
END; 

/* Функция */
CREATE FUNCTION F_Multiple2
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
    IF (NOT (i_FOR1 < 3)) THEN                       
    BEGIN 
      i_FOR1 = i_FOR1 + 1; 
      CONTINUE;
    END
      summa = :summa + :i_FOR1;
      i_FOR1 = i_FOR1 + 1;
  END
  i_FOR1 = bound_i_FOR1;
  WHILE (1=1) DO
  BEGIN
    i_FOR1 = i_FOR1;
    summa = :summa + i_FOR1;
    LEAVE;
  END
  RETURN summa;  -- 6
END; 

/* Пакет */
CREATE OR ALTER PACKAGE Pack_Multiple2
AS BEGIN
   FUNCTION PF_Multiple2
   RETURNS INTEGER;
   PROCEDURE PP_Multiple2; 
END; 

/* Тело пакета */
RECREATE PACKAGE BODY Pack_Multiple2
AS BEGIN
   FUNCTION PF_Multiple2
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
       IF (NOT (i_FOR1 < 3)) THEN                       
       BEGIN 
         i_FOR1 = i_FOR1 + 1; 
         CONTINUE;
       END
         summa = :summa + :i_FOR1;
         i_FOR1 = i_FOR1 + 1;
     END
     i_FOR1 = bound_i_FOR1;
     WHILE (1=1) DO
     BEGIN
       i_FOR1 = i_FOR1;
       summa = :summa + i_FOR1;
       LEAVE;
     END
     RETURN summa;
   END

   PROCEDURE PP_Multiple2
   AS
     DECLARE summa INTEGER = 0;
     DECLARE i_FOR1 INTEGER;
     DECLARE bound_i_FOR1 INTEGER;
   BEGIN
     i_FOR1 = 1;
     bound_i_FOR1 = 3;
     WHILE (i_FOR1 <= bound_i_FOR1) DO
     BEGIN 
       IF (NOT (i_FOR1 < 3)) THEN                       
       BEGIN 
         i_FOR1 = i_FOR1 + 1; 
         CONTINUE;
       END
         summa = :summa + :i_FOR1;
         i_FOR1 = i_FOR1 + 1;
     END
     i_FOR1 = bound_i_FOR1;
     WHILE (1=1) DO
     BEGIN
       i_FOR1 = i_FOR1;
       summa = :summa + i_FOR1;
       LEAVE;
     END
   END
END; 

/* Триггер DML */
CREATE OR ALTER TRIGGER T_Multiple2
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
    IF (NOT (i_FOR1 < 3)) THEN                       
    BEGIN 
      i_FOR1 = i_FOR1 + 1; 
      CONTINUE;
    END
      summa = :summa + :i_FOR1;
      i_FOR1 = i_FOR1 + 1;
  END
  i_FOR1 = bound_i_FOR1;
  WHILE (1=1) DO
  BEGIN
    i_FOR1 = i_FOR1;
    summa = :summa + i_FOR1;
    LEAVE;
  END
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
    IF (NOT (i_FOR1 < 3)) THEN                       
    BEGIN 
      i_FOR1 = i_FOR1 + 1; 
      CONTINUE;
    END
      summa = :summa + :i_FOR1;
      i_FOR1 = i_FOR1 + 1;
  END
  i_FOR1 = bound_i_FOR1;
  WHILE (1=1) DO
  BEGIN
    i_FOR1 = i_FOR1;
    summa = :summa + i_FOR1;
    LEAVE;
  END
END; 
