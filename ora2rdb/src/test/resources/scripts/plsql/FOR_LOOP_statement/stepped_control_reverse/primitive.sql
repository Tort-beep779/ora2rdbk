/* Процедура */
CREATE PROCEDURE P_Primitive
IS
  summa PLS_INTEGER := 0;
  done CHAR(1) := 'F';
BEGIN
  FOR i IN REVERSE 1..3 LOOP
      summa := summa + i;
      done := 'T';
  END LOOP;
END; 

/* Функция */
CREATE FUNCTION F_Primitive
RETURN PLS_INTEGER
IS
  summa PLS_INTEGER := 0;
  done CHAR(1) := 'F';
BEGIN
  FOR i IN REVERSE 1..3 LOOP
      summa := summa + i;
      done := 'T';
  END LOOP;
  RETURN summa;
END; 

/* Пакет */
CREATE OR REPLACE PACKAGE Pack_Primitive
AS 
   FUNCTION PF_Primitive 
   RETURN PLS_INTEGER;
   PROCEDURE PP_Primitive; 
END; 

/* Тело пакета */
CREATE OR REPLACE PACKAGE BODY Pack_Primitive
AS 
   FUNCTION PF_Primitive
   RETURN PLS_INTEGER
   IS
     summa PLS_INTEGER := 0;
     done CHAR(1) := 'F';
   BEGIN
     FOR i IN REVERSE 1..3 LOOP
      summa := summa + i;
      done := 'T';
     END LOOP;
     RETURN summa;
   END;

   PROCEDURE PP_Primitive
   IS
     summa PLS_INTEGER := 0;
     done CHAR(1) := 'F';
   BEGIN
     FOR i IN REVERSE 1..3 LOOP
      summa := summa + i;
      done := 'T';
     END LOOP;
   END; 
END; 

/* Триггер DML */
CREATE OR REPLACE TRIGGER T_Primitive
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  summa PLS_INTEGER := 0;
  done CHAR(1) := 'F';
BEGIN
  FOR i IN REVERSE 1..3 LOOP
      summa := summa + i;
      done := 'T';
  END LOOP;
END;

/* Анонимный блок */
DECLARE
  summa PLS_INTEGER := 0;
  done CHAR(1) := 'F';
BEGIN
  FOR i IN REVERSE 1..3 LOOP
      summa := summa + i;
      done := 'T';
  END LOOP;
END; 