/* Процедура */
CREATE PROCEDURE P_Primitive
AS
  DECLARE summa INTEGER = 0;
  DECLARE done CHAR(1) = 'F';
  DECLARE i_FOR1 INTEGER;
  DECLARE bound_i_FOR1 INTEGER;
BEGIN
  i_FOR1 = 3;
  bound_i_FOR1 = 1;
  WHILE (i_FOR1 >= bound_i_FOR1) DO
  BEGIN 
      summa = :summa + :i_FOR1;
      done = 'T';
      i_FOR1 = i_FOR1 - 1;
  END
  i_FOR1 = bound_i_FOR1;
END;

/* Функция */
CREATE FUNCTION F_Primitive
RETURNS INTEGER
AS
  DECLARE summa INTEGER = 0;
  DECLARE done CHAR(1) = 'F';
  DECLARE i_FOR1 INTEGER;
  DECLARE bound_i_FOR1 INTEGER;
BEGIN
  i_FOR1 = 3;
  bound_i_FOR1 = 1;
  WHILE (i_FOR1 >= bound_i_FOR1) DO
  BEGIN 
      summa = :summa + :i_FOR1;
      done = 'T';
      i_FOR1 = i_FOR1 - 1;
  END
  i_FOR1 = bound_i_FOR1;
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
     DECLARE bound_i_FOR1 INTEGER;
   BEGIN
     i_FOR1 = 3;
     bound_i_FOR1 = 1;
     WHILE (i_FOR1 >= bound_i_FOR1) DO
     BEGIN 
       summa = :summa + :i_FOR1;
       done = 'T';
       i_FOR1 = i_FOR1 - 1;
     END
     i_FOR1 = bound_i_FOR1;
     RETURN summa;
   END

   PROCEDURE PP_Primitive
   AS
     DECLARE summa INTEGER = 0;
     DECLARE done CHAR(1) = 'F';
     DECLARE i_FOR1 INTEGER;
     DECLARE bound_i_FOR1 INTEGER;
   BEGIN
     i_FOR1 = 3;
     bound_i_FOR1 = 1;
     WHILE (i_FOR1 >= bound_i_FOR1) DO
     BEGIN 
       summa = :summa + :i_FOR1;
       done = 'T';
       i_FOR1 = i_FOR1 - 1;
     END
     i_FOR1 = bound_i_FOR1;
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
  DECLARE bound_i_FOR1 INTEGER;
BEGIN
  i_FOR1 = 3;
  bound_i_FOR1 = 1;
  WHILE (i_FOR1 >= bound_i_FOR1) DO
  BEGIN 
      summa = :summa + :i_FOR1;
      done = 'T';
      i_FOR1 = i_FOR1 - 1;
  END
  i_FOR1 = bound_i_FOR1;
END;

/* Анонимный блок */
EXECUTE BLOCK 
AS
  DECLARE summa INTEGER = 0;
  DECLARE done CHAR(1) = 'F';
  DECLARE i_FOR1 INTEGER;
  DECLARE bound_i_FOR1 INTEGER;
BEGIN
  i_FOR1 = 3;
  bound_i_FOR1 = 1;
  WHILE (i_FOR1 >= bound_i_FOR1) DO
  BEGIN 
      summa = :summa + :i_FOR1;
      done = 'T';
      i_FOR1 = i_FOR1 - 1;
  END
  i_FOR1 = bound_i_FOR1;
END; 