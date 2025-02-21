/* Процедура */
CREATE PROCEDURE P_Index_With_Label
AS
  DECLARE summa INTEGER = 0;
  DECLARE i_FOR1 INTEGER;
  DECLARE bound_i_FOR1 INTEGER;
BEGIN
  i_FOR1 = 1;
  bound_i_FOR1 = 3;
  forlabel:
  WHILE (i_FOR1 <= bound_i_FOR1) DO
  BEGIN 
      summa = :summa + :i_FOR1;
      i_FOR1 = i_FOR1 + 1;
  END /*forlabel*/
  i_FOR1 = bound_i_FOR1;
  i_FOR1 = 3;
  bound_i_FOR1 = 1;
  forlabel:
  WHILE (i_FOR1 >= bound_i_FOR1) DO
  BEGIN 
      summa = :summa + :i_FOR1;
      i_FOR1 = i_FOR1 - 1;
  END /*forlabel*/
  i_FOR1 = bound_i_FOR1;
  i_FOR1 = 10;
  bound_i_FOR1 = 12;
  forlabel:
  WHILE (i_FOR1 <= bound_i_FOR1) DO
  BEGIN 
      summa = :summa + :i_FOR1;
      i_FOR1 = i_FOR1 + 1;
  END /*forlabel*/
  i_FOR1 = bound_i_FOR1;
END;

/* Функция */
CREATE FUNCTION F_Index_With_Label
RETURNS INTEGER
AS
  DECLARE summa INTEGER = 0;
  DECLARE i_FOR1 INTEGER;
  DECLARE bound_i_FOR1 INTEGER;
BEGIN
  i_FOR1 = 1;
  bound_i_FOR1 = 3;
  forlabel:
  WHILE (i_FOR1 <= bound_i_FOR1) DO
  BEGIN 
      summa = :summa + :i_FOR1;
      i_FOR1 = i_FOR1 + 1;
  END /*forlabel*/
  i_FOR1 = bound_i_FOR1;
  i_FOR1 = 3;
  bound_i_FOR1 = 1;
  forlabel:
  WHILE (i_FOR1 >= bound_i_FOR1) DO
  BEGIN 
      summa = :summa + :i_FOR1;
      i_FOR1 = i_FOR1 - 1;
  END /*forlabel*/
  i_FOR1 = bound_i_FOR1;
  i_FOR1 = 10;
  bound_i_FOR1 = 12;
  forlabel:
  WHILE (i_FOR1 <= bound_i_FOR1) DO
  BEGIN 
      summa = :summa + :i_FOR1;
      i_FOR1 = i_FOR1 + 1;
  END /*forlabel*/
  i_FOR1 = bound_i_FOR1;
  RETURN summa;  -- 45
END; 

/* Пакет */
CREATE OR ALTER PACKAGE Pack_Index_With_Label
AS BEGIN
   FUNCTION PF_Index_With_Label
   RETURNS INTEGER;
   PROCEDURE PP_Index_With_Label; 
END; 

/* Тело пакета */
RECREATE PACKAGE BODY Pack_Index_With_Label
AS BEGIN
   FUNCTION PF_Index_With_Label
   RETURNS INTEGER
   AS
     DECLARE summa INTEGER = 0;
     DECLARE i_FOR1 INTEGER;
     DECLARE bound_i_FOR1 INTEGER;
   BEGIN
     i_FOR1 = 1;
     bound_i_FOR1 = 3;
     forlabel:
     WHILE (i_FOR1 <= bound_i_FOR1) DO
     BEGIN 
        summa = :summa + :i_FOR1;
        i_FOR1 = i_FOR1 + 1;
     END /*forlabel*/
     i_FOR1 = bound_i_FOR1;
     i_FOR1 = 3;
     bound_i_FOR1 = 1;
     forlabel:
     WHILE (i_FOR1 >= bound_i_FOR1) DO
     BEGIN 
        summa = :summa + :i_FOR1;
        i_FOR1 = i_FOR1 - 1;
     END /*forlabel*/
     i_FOR1 = bound_i_FOR1;
     i_FOR1 = 10;
     bound_i_FOR1 = 12;
     forlabel:
     WHILE (i_FOR1 <= bound_i_FOR1) DO
     BEGIN 
        summa = :summa + :i_FOR1;
        i_FOR1 = i_FOR1 + 1;
     END /*forlabel*/
     i_FOR1 = bound_i_FOR1;
     RETURN summa;
   END

   PROCEDURE PP_Index_With_Label
   AS
     DECLARE summa INTEGER = 0;
     DECLARE i_FOR1 INTEGER;
     DECLARE bound_i_FOR1 INTEGER;
   BEGIN
     i_FOR1 = 1;
     bound_i_FOR1 = 3;
     forlabel:
     WHILE (i_FOR1 <= bound_i_FOR1) DO
     BEGIN 
        summa = :summa + :i_FOR1;
        i_FOR1 = i_FOR1 + 1;
     END /*forlabel*/
     i_FOR1 = bound_i_FOR1;
     i_FOR1 = 3;
     bound_i_FOR1 = 1;
     forlabel:
     WHILE (i_FOR1 >= bound_i_FOR1) DO
     BEGIN 
        summa = :summa + :i_FOR1;
        i_FOR1 = i_FOR1 - 1;
     END /*forlabel*/
     i_FOR1 = bound_i_FOR1;
     i_FOR1 = 10;
     bound_i_FOR1 = 12;
     forlabel:
     WHILE (i_FOR1 <= bound_i_FOR1) DO
     BEGIN 
        summa = :summa + :i_FOR1;
        i_FOR1 = i_FOR1 + 1;
     END /*forlabel*/
     i_FOR1 = bound_i_FOR1;
   END
END; 

/* Триггер DML */
CREATE OR ALTER TRIGGER T_Index_With_Label
  AFTER INSERT 
  ON students
AS
  DECLARE summa INTEGER = 0;
  DECLARE i_FOR1 INTEGER;
  DECLARE bound_i_FOR1 INTEGER;
BEGIN
  i_FOR1 = 1;
  bound_i_FOR1 = 3;
  forlabel:
  WHILE (i_FOR1 <= bound_i_FOR1) DO
  BEGIN 
      summa = :summa + :i_FOR1;
      i_FOR1 = i_FOR1 + 1;
  END /*forlabel*/
  i_FOR1 = bound_i_FOR1;
  i_FOR1 = 3;
  bound_i_FOR1 = 1;
  forlabel:
  WHILE (i_FOR1 >= bound_i_FOR1) DO
  BEGIN 
      summa = :summa + :i_FOR1;
      i_FOR1 = i_FOR1 - 1;
  END /*forlabel*/
  i_FOR1 = bound_i_FOR1;
  i_FOR1 = 10;
  bound_i_FOR1 = 12;
  forlabel:
  WHILE (i_FOR1 <= bound_i_FOR1) DO
  BEGIN 
      summa = :summa + :i_FOR1;
      i_FOR1 = i_FOR1 + 1;
  END /*forlabel*/
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
  forlabel:
  WHILE (i_FOR1 <= bound_i_FOR1) DO
  BEGIN 
      summa = :summa + :i_FOR1;
      i_FOR1 = i_FOR1 + 1;
  END /*forlabel*/
  i_FOR1 = bound_i_FOR1;
  i_FOR1 = 3;
  bound_i_FOR1 = 1;
  forlabel:
  WHILE (i_FOR1 >= bound_i_FOR1) DO
  BEGIN 
      summa = :summa + :i_FOR1;
      i_FOR1 = i_FOR1 - 1;
  END /*forlabel*/
  i_FOR1 = bound_i_FOR1;
  i_FOR1 = 10;
  bound_i_FOR1 = 12;
  forlabel:
  WHILE (i_FOR1 <= bound_i_FOR1) DO
  BEGIN 
      summa = :summa + :i_FOR1;
      i_FOR1 = i_FOR1 + 1;
  END /*forlabel*/
  i_FOR1 = bound_i_FOR1;
END; -- 45