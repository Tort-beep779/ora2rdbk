/* Процедура */
CREATE PROCEDURE P_From_Assoc_Array
IS
  summa PLS_INTEGER := 0;
  TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
  vec intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34);
BEGIN
  FOR i IN REVERSE INDICES OF vec LOOP
      summa := summa + i;  
  END LOOP;
END; 

/* Функция */
CREATE FUNCTION F_From_Assoc_Array
RETURN PLS_INTEGER
IS
  summa PLS_INTEGER := 0;
  TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
  vec intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34);
BEGIN
  FOR i IN REVERSE INDICES OF vec LOOP
      summa := summa + i;  
  END LOOP;
  RETURN summa; -- 55
END; 

/* Пакет */
CREATE OR REPLACE PACKAGE Pack_From_Assoc_Array
AS 
   FUNCTION PF_From_Assoc_Array
   RETURN PLS_INTEGER;
   PROCEDURE PP_From_Assoc_Array; 
END; 

/* Тело пакета */
CREATE OR REPLACE PACKAGE BODY Pack_From_Assoc_Array
AS 
   FUNCTION PF_From_Assoc_Array
   RETURN PLS_INTEGER
   IS
     summa PLS_INTEGER := 0;
     TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
     vec intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34);
   BEGIN
     FOR i IN REVERSE INDICES OF vec LOOP
      summa := summa + i;   
     END LOOP;
     RETURN summa;
   END;

   PROCEDURE PP_From_Assoc_Array
   IS
     summa PLS_INTEGER := 0;
     TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
     vec intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34);
   BEGIN
     FOR i IN REVERSE INDICES OF vec LOOP
      summa := summa + i; 
     END LOOP;
   END; 
END; 

/* Триггер DML */
CREATE OR REPLACE TRIGGER T_From_Assoc_Array
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  summa PLS_INTEGER := 0;
  TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
  vec intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34);
BEGIN
  FOR i IN REVERSE INDICES OF vec LOOP
      summa := summa + i;
   END LOOP;
END;

/* Анонимный блок */
DECLARE
   TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
   vec intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34);
   summa PLS_INTEGER := 0;
BEGIN
   FOR i IN REVERSE INDICES OF vec LOOP
      summa := summa + i;   -- 55
   END LOOP;
END;