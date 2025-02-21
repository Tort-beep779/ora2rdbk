/* Процедура */
CREATE PROCEDURE P_Mutable_Index
IS
  summa PLS_INTEGER := 0;
  TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
  vec intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34);
BEGIN
  FOR i, j MUTABLE IN PAIRS OF vec LOOP
      j := 100;
      summa := summa + i;  
  END LOOP;
END; 

/* Функция */
CREATE FUNCTION F_Mutable_Index
RETURN PLS_INTEGER
IS
  summa PLS_INTEGER := 0;
  TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
  vec intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34);
BEGIN
  FOR i, j MUTABLE IN PAIRS OF vec LOOP
      j := 100;
      summa := summa + i;  
  END LOOP;
  RETURN summa; -- 55
END; 

/* Пакет */
CREATE OR REPLACE PACKAGE Pack_Mutable_Index
AS 
   FUNCTION PF_Mutable_Index
   RETURN PLS_INTEGER;
   PROCEDURE PP_Mutable_Index; 
END; 

/* Тело пакета */
CREATE OR REPLACE PACKAGE BODY Pack_Mutable_Index
AS 
   FUNCTION PF_Mutable_Index
   RETURN PLS_INTEGER
   IS
     summa PLS_INTEGER := 0;
     TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
     vec intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34);
   BEGIN
     FOR i, j MUTABLE IN PAIRS OF vec LOOP
      j := 100;
      summa := summa + i;   
     END LOOP;
     RETURN summa;
   END;

   PROCEDURE PP_Mutable_Index
   IS
     summa PLS_INTEGER := 0;
     TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
     vec intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34);
   BEGIN
     FOR i, j MUTABLE IN PAIRS OF vec LOOP
      j := 100;
      summa := summa + i; 
     END LOOP;
   END; 
END; 

/* Триггер DML */
CREATE OR REPLACE TRIGGER T_Mutable_Index
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  summa PLS_INTEGER := 0;
  TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
  vec intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34);
BEGIN
  FOR i, j MUTABLE IN PAIRS OF vec LOOP
      j := 100;
      summa := summa + i;
   END LOOP;
END;

/* Анонимный блок */
DECLARE
   TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
   vec intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34);
   summa PLS_INTEGER := 0;
BEGIN
   FOR i, j MUTABLE IN PAIRS OF vec LOOP
      j := 100;
      summa := summa + i;   
   END LOOP;
END;