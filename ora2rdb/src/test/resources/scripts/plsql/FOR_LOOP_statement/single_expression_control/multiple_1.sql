/* Процедура */
CREATE PROCEDURE P_Multiple1
IS
  summa PLS_INTEGER := 0;
  power PLS_INTEGER;
BEGIN
  power := 7;
  FOR i IN REPEAT power+1 while power < 20, 21, 1..3
  LOOP
      summa := summa + i;
      power := power + 1;
  END LOOP;
END; 

/* Функция */
CREATE FUNCTION F_Multiple1
RETURN PLS_INTEGER
IS
  summa PLS_INTEGER := 0;
  power PLS_INTEGER;
BEGIN
  power := 7;
  FOR i IN REPEAT power+1 while power < 20, 21, 1..3
  LOOP
      summa := summa + i;
      power := power + 1;
  END LOOP;
  RETURN summa; 
END; 

/* Пакет */
CREATE OR REPLACE PACKAGE Pack_Multiple1
AS 
   FUNCTION PF_Multiple1
   RETURN PLS_INTEGER;
   PROCEDURE PP_Multiple1; 
END; 

/* Тело пакета */
CREATE OR REPLACE PACKAGE BODY Pack_Multiple1
AS 
   FUNCTION PF_Multiple1
   RETURN PLS_INTEGER
   IS
     summa PLS_INTEGER := 0;
     power PLS_INTEGER;
   BEGIN
     power := 7;
     FOR i IN REPEAT power+1 while power < 20, 21, 1..3
     LOOP
       summa := summa + i;
       power := power + 1;
     END LOOP;
     RETURN summa;
   END;

   PROCEDURE PP_Multiple1
   IS
     summa PLS_INTEGER := 0;
     power PLS_INTEGER;
   BEGIN
     power := 7;
     FOR i IN REPEAT power+1 while power < 20, 21, 1..3
     LOOP
       summa := summa + i;
       power := power + 1;
     END LOOP;
   END; 
END; 

/* Триггер DML */
CREATE OR REPLACE TRIGGER T_Multiple1
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  summa PLS_INTEGER := 0;
  power PLS_INTEGER;
BEGIN
  power := 7;
  FOR i IN REPEAT power+1 while power < 20, 21, 1..3
  LOOP
      summa := summa + i;
      power := power + 1;
  END LOOP;
END;

/* Анонимный блок */
DECLARE
  summa PLS_INTEGER := 0;
  power PLS_INTEGER;
BEGIN
  power := 7;
  FOR i IN REPEAT power+1 while power < 20, 21, 1..3
  LOOP
      summa := summa + i;
      power := power + 1;
  END LOOP;
END; 
