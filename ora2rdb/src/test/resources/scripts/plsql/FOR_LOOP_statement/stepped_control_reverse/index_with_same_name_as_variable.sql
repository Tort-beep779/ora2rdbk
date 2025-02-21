/* Процедура */
CREATE PROCEDURE P_Same_Name_Var
IS
  summa PLS_INTEGER := 0;
  i PLS_INTEGER;
BEGIN
  FOR i IN REVERSE 1..3 LOOP
      summa := summa + i;
  END LOOP;
  i := 10;
  summa := summa + i;
END; 

/* Функция */
CREATE FUNCTION F_Same_Name_Var
RETURN PLS_INTEGER
IS
  summa PLS_INTEGER := 0;
  i PLS_INTEGER;
BEGIN
  FOR i IN REVERSE 1..3 LOOP
      summa := summa + i;
  END LOOP;
  i := 10;
  summa := summa + i;
  RETURN summa;  -- 16
END; 

/* Пакет */
CREATE OR REPLACE PACKAGE Pack_Same_Name_Var
AS 
   FUNCTION PF_Same_Name_Var
   RETURN PLS_INTEGER;
   PROCEDURE PP_Same_Name_Var; 
END; 

/* Тело пакета */
CREATE OR REPLACE PACKAGE BODY Pack_Same_Name_Var
AS 
   FUNCTION PF_Same_Name_Var
   RETURN PLS_INTEGER
   IS
     summa PLS_INTEGER := 0;
     i PLS_INTEGER;
   BEGIN
     FOR i IN REVERSE 1..3 LOOP
      summa := summa + i;
     END LOOP;
     i := 10;
     summa := summa + i;
     RETURN summa;
   END;

   PROCEDURE PP_Same_Name_Var
   IS
     summa PLS_INTEGER := 0;
     i PLS_INTEGER;
   BEGIN
     FOR i IN REVERSE 1..3 LOOP
       summa := summa + i;
     END LOOP;
     i := 10;
     summa := summa + i;
   END; 
END; 

/* Триггер DML */
CREATE OR REPLACE TRIGGER T_Same_Name_Var
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  summa PLS_INTEGER := 0;
  i PLS_INTEGER;
BEGIN
  FOR i IN REVERSE 1..3 LOOP
      summa := summa + i;
  END LOOP;
  i := 10;
  summa := summa + i;
END;

/* Анонимный блок */
DECLARE
  summa PLS_INTEGER := 0;
  i PLS_INTEGER;
BEGIN
  FOR i IN REVERSE 1..3 LOOP
      summa := summa + i;
  END LOOP;
  i := 10;
  summa := summa + i;  -- 16
END; 