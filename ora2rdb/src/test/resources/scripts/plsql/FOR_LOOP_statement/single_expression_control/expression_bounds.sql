/* Процедура */
CREATE PROCEDURE P_Expr_Bounds
IS
  summa PLS_INTEGER := 0;
  power PLS_INTEGER;
BEGIN
  power := 7;
  FOR i IN REPEAT power+1 while power < 20
  LOOP
      summa := summa + i;
      power := power + 1;
  END LOOP;
END; 

/* Функция */
CREATE FUNCTION F_Expr_Bounds
RETURN PLS_INTEGER
IS
  summa PLS_INTEGER := 0;
  power PLS_INTEGER;
BEGIN
  power := 7;
  FOR i IN REPEAT power+1 while power < 20
  LOOP
      summa := summa + i;
      power := power + 1;
  END LOOP;
  RETURN summa; 
END; 

/* Пакет */
CREATE OR REPLACE PACKAGE Pack_Expr_Bounds
AS 
   FUNCTION PF_Expr_Bounds
   RETURN PLS_INTEGER;
   PROCEDURE PP_Expr_Bounds; 
END; 

/* Тело пакета */
CREATE OR REPLACE PACKAGE BODY Pack_Expr_Bounds
AS 
   FUNCTION PF_Expr_Bounds
   RETURN PLS_INTEGER
   IS
     summa PLS_INTEGER := 0;
     power PLS_INTEGER;
   BEGIN
     power := 7;
     FOR i IN REPEAT power+1 while power < 20
     LOOP
       summa := summa + i;
       power := power + 1;
     END LOOP;
     RETURN summa;
   END;

   PROCEDURE PP_Expr_Bounds
   IS
     summa PLS_INTEGER := 0;
     power PLS_INTEGER;
   BEGIN
     power := 7;
     FOR i IN REPEAT power+1 while power < 20
     LOOP
       summa := summa + i;
       power := power + 1;
     END LOOP;
   END; 
END; 

/* Триггер DML */
CREATE OR REPLACE TRIGGER T_Expr_Bounds
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  summa PLS_INTEGER := 0;
  power PLS_INTEGER;
BEGIN
  power := 7;
  FOR i IN REPEAT power+1 while power < 20
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
  FOR i IN REPEAT power+1 while power < 20
  LOOP
      summa := summa + i;
      power := power + 1;
  END LOOP;
END; 
