/* Процедура */
CREATE PROCEDURE P_For_With_While
IS
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN 1..3 WHILE i != 2
  LOOP
      summa := summa + i;
  END LOOP;
END; 

/* Функция */
CREATE FUNCTION F_For_With_While
RETURN PLS_INTEGER
IS
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN 1..3 WHILE i != 2
  LOOP
      summa := summa + i;
  END LOOP;
  RETURN summa;  -- 1
END; 

/* Пакет */
CREATE OR REPLACE PACKAGE Pack_For_With_While
AS 
   FUNCTION PF_For_With_While
   RETURN PLS_INTEGER;
   PROCEDURE PP_For_With_While; 
END; 

/* Тело пакета */
CREATE OR REPLACE PACKAGE BODY Pack_For_With_While
AS 
   FUNCTION PF_For_With_While
   RETURN PLS_INTEGER
   IS
     summa PLS_INTEGER := 0;
   BEGIN
     FOR i IN 1..3 WHILE i != 2
     LOOP
      summa := summa + i;
     END LOOP;
     RETURN summa;
   END;

   PROCEDURE PP_For_With_While
   IS
     summa PLS_INTEGER := 0;
   BEGIN
     FOR i IN 1..3 WHILE i != 2
     LOOP
      summa := summa + i;
     END LOOP;
   END; 
END; 

/* Триггер DML */
CREATE OR REPLACE TRIGGER T_For_With_While
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN 1..3 WHILE i != 2
  LOOP
      summa := summa + i;
  END LOOP;
END;

/* Анонимный блок */
DECLARE
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN 1..3 WHILE i != 2
  LOOP
      summa := summa + i;  -- 1
  END LOOP;
END; 