/* Процедура */
CREATE PROCEDURE P_For_With_Label
IS
  summa PLS_INTEGER := 0;
BEGIN
  <<forlabel>>
  FOR i IN 1..3
  LOOP
    summa := summa + i;
  END LOOP forlabel;
END; 

/* Функция */
CREATE FUNCTION F_For_With_Label
RETURN PLS_INTEGER
IS
  summa PLS_INTEGER := 0;
BEGIN
  <<forlabel>>
  FOR i IN 1..3  
  LOOP
      summa := summa + i;
  END LOOP forlabel;
  RETURN summa;  -- 6
END; 

/* Пакет */
CREATE OR REPLACE PACKAGE Pack_For_With_Label
AS 
   FUNCTION PF_For_With_Label
   RETURN PLS_INTEGER;
   PROCEDURE PP_For_With_Label; 
END; 

/* Тело пакета */
CREATE OR REPLACE PACKAGE BODY Pack_For_With_Label
AS 
   FUNCTION PF_For_With_Label
   RETURN PLS_INTEGER
   IS
     summa PLS_INTEGER := 0;
   BEGIN
     <<forlabel>>
     FOR i IN 1..3  
     LOOP
       summa := summa + i;
     END LOOP forlabel;
     RETURN summa;
   END;

   PROCEDURE PP_For_With_Label
   IS
     summa PLS_INTEGER := 0;
   BEGIN
     <<forlabel>>
     FOR i IN 1..3 
     LOOP
       summa := summa + i;
     END LOOP forlabel;
   END; 
END; 

/* Триггер DML */
CREATE OR REPLACE TRIGGER T_For_With_Label
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  summa PLS_INTEGER := 0;
BEGIN
  <<forlabel>>
  FOR i IN 1..3 
  LOOP
      summa := summa + i;
  END LOOP forlabel;
END;

/* Анонимный блок */
DECLARE
  summa PLS_INTEGER := 0;
BEGIN
  <<forlabel>>
  FOR i IN 1..3
  LOOP
      summa := summa + i; 
  END LOOP forlabel;
END; 