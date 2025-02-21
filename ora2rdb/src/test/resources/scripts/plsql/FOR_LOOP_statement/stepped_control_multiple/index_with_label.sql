/* Процедура */
CREATE PROCEDURE P_Index_With_Label
IS
  summa PLS_INTEGER := 0;
BEGIN
  <<forlabel>>
  FOR i IN 1..3, REVERSE 1..3, 10..12 
  LOOP
    summa := summa + forlabel.i;
  END LOOP forlabel;
END; 

/* Функция */
CREATE FUNCTION F_Index_With_Label
RETURN PLS_INTEGER
IS
  summa PLS_INTEGER := 0;
BEGIN
  <<forlabel>>
  FOR i IN 1..3, REVERSE 1..3, 10..12 
  LOOP
      summa := summa + forlabel.i;
  END LOOP forlabel;
  RETURN summa;  -- 45
END; 

/* Пакет */
CREATE OR REPLACE PACKAGE Pack_Index_With_Label
AS 
   FUNCTION PF_Index_With_Label
   RETURN PLS_INTEGER;
   PROCEDURE PP_Index_With_Label; 
END; 

/* Тело пакета */
CREATE OR REPLACE PACKAGE BODY Pack_Index_With_Label
AS 
   FUNCTION PF_Index_With_Label
   RETURN PLS_INTEGER
   IS
     summa PLS_INTEGER := 0;
   BEGIN
     <<forlabel>>
     FOR i IN 1..3, REVERSE 1..3, 10..12 
     LOOP
       summa := summa + forlabel.i;
     END LOOP forlabel;
     RETURN summa;
   END;

   PROCEDURE PP_Index_With_Label
   IS
     summa PLS_INTEGER := 0;
   BEGIN
     <<forlabel>>
     FOR i IN 1..3, REVERSE 1..3, 10..12 
     LOOP
       summa := summa + forlabel.i;
     END LOOP forlabel;
   END; 
END; 

/* Триггер DML */
CREATE OR REPLACE TRIGGER T_Index_With_Label
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  summa PLS_INTEGER := 0;
BEGIN
  <<forlabel>>
  FOR i IN 1..3, REVERSE 1..3, 10..12 
  LOOP
      summa := summa + forlabel.i;
  END LOOP forlabel;
END;

/* Анонимный блок */
DECLARE
  summa PLS_INTEGER := 0;
BEGIN
  <<forlabel>>
  FOR i IN 1..3, REVERSE 1..3, 10..12 
  LOOP
      summa := summa + forlabel.i;  -- 45
  END LOOP forlabel;
END; 