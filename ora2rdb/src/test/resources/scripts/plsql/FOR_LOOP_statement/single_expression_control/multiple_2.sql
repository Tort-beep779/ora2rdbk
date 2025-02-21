/* Процедура */
CREATE PROCEDURE P_Multiple2
IS
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN 1..3 WHEN i < 3, i
  LOOP
      summa := summa + i;
  END LOOP;
END; 

/* Функция */
CREATE FUNCTION F_Multiple2
RETURN PLS_INTEGER
IS
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN 1..3 WHEN i < 3, i
  LOOP
      summa := summa + i;
  END LOOP;
  RETURN summa; 
END; 

/* Пакет */
CREATE OR REPLACE PACKAGE Pack_Multiple2
AS 
   FUNCTION PF_Multiple2
   RETURN PLS_INTEGER;
   PROCEDURE PP_Multiple2; 
END; 

/* Тело пакета */
CREATE OR REPLACE PACKAGE BODY Pack_Multiple2
AS 
   FUNCTION PF_Multiple2
   RETURN PLS_INTEGER
   IS
     summa PLS_INTEGER := 0;
   BEGIN
     FOR i IN 1..3 WHEN i < 3, i
     LOOP
       summa := summa + i;
     END LOOP;
     RETURN summa;
   END;

   PROCEDURE PP_Multiple2
   IS
     summa PLS_INTEGER := 0;
   BEGIN
     FOR i IN 1..3 WHEN i < 3, i
     LOOP
       summa := summa + i;
     END LOOP;
   END; 
END; 

/* Триггер DML */
CREATE OR REPLACE TRIGGER T_Multiple2
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN 1..3 WHEN i < 3, i
  LOOP
      summa := summa + i;
  END LOOP;
END;

/* Анонимный блок */
DECLARE
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN 1..3 WHEN i < 3, i
  LOOP
      summa := summa + i;
  END LOOP;
END; 
