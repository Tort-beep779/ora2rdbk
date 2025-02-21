/* Процедура */
CREATE PROCEDURE P_From_Varray
IS
  TYPE varray_t IS VARRAY(4) OF VARCHAR2(15);
  vec varray_t := varray_t('John', 'Mary', 'Alberto', 'Juanita');
  summa PLS_INTEGER := 0;
BEGIN
   FOR i, j IN PAIRS OF vec LOOP
      summa := summa + i;
   END LOOP;
END;

/* Функция */
CREATE FUNCTION F_From_Varray
RETURN VARCHAR2(100)
IS
   TYPE varray_t IS VARRAY(4) OF VARCHAR2(15);
   vec varray_t := varray_t('John', 'Mary', 'Alberto', 'Juanita');
   summa PLS_INTEGER := 0;
BEGIN
   FOR i, j IN PAIRS OF vec LOOP
      summa := summa + i;
   END LOOP;
END;

/* Пакет */
CREATE OR REPLACE PACKAGE Pack_From_Varray
AS 
   FUNCTION PF_From_Varray
   RETURN VARCHAR2(100);
   PROCEDURE PP_From_Varray; 
END; 

/* Тело пакета */
CREATE OR REPLACE PACKAGE BODY Pack_From_Varray
AS 
   FUNCTION PF_From_Varray
   RETURN VARCHAR2(100)
   IS
     TYPE varray_t IS VARRAY(4) OF VARCHAR2(15);
     vec varray_t := varray_t('John', 'Mary', 'Alberto', 'Juanita');
     summa PLS_INTEGER := 0;
   BEGIN
     FOR i, j IN PAIRS OF vec LOOP
       summa := summa + i;
     END LOOP;
     RETURN summa;
   END;

   PROCEDURE PP_From_Varray
   IS
     TYPE varray_t IS VARRAY(4) OF VARCHAR2(15);
     vec varray_t := varray_t('John', 'Mary', 'Alberto', 'Juanita');
     summa PLS_INTEGER := 0;
   BEGIN
     FOR i, j IN PAIRS OF vec LOOP
       summa := summa + i;
     END LOOP;
   END;
END;  

/* Триггер DML */
CREATE OR REPLACE TRIGGER T_From_Varray
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  TYPE varray_t IS VARRAY(4) OF VARCHAR2(15);
   vec varray_t := varray_t('John', 'Mary', 'Alberto', 'Juanita');
   summa PLS_INTEGER := 0;
BEGIN
   FOR i, j IN PAIRS OF vec LOOP
      summa := summa + i;
   END LOOP;
END;

/* Анонимный блок */
DECLARE
   TYPE varray_t IS VARRAY(4) OF VARCHAR2(15);
   vec varray_t := varray_t('John', 'Mary', 'Alberto', 'Juanita');
   summa PLS_INTEGER := 0;
BEGIN
   FOR i, j IN PAIRS OF vec LOOP
      summa := summa + i;
   END LOOP;
END;