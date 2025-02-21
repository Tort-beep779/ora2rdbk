/* Процедура */
CREATE PROCEDURE P_Few_Fors
IS
  TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
  vec1 intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34);
  TYPE varray_t IS VARRAY(4) OF VARCHAR2(15);
  vec2 varray_t := varray_t('John', 'Mary', 'Alberto', 'Juanita');
BEGIN
  FOR i, j IN PAIRS OF vec1 LOOP
     null;
  END LOOP;
  FOR i, j IN PAIRS OF vec2 LOOP
      null;
  END LOOP;
END; 

/* Функция */
CREATE FUNCTION F_Few_Fors
RETURN PLS_INTEGER
IS
  TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
  vec1 intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34);
  TYPE varray_t IS VARRAY(4) OF VARCHAR2(15);
  vec2 varray_t := varray_t('John', 'Mary', 'Alberto', 'Juanita');
BEGIN
  FOR i, j IN PAIRS OF vec1 LOOP
     null;
  END LOOP;
  FOR i, j IN PAIRS OF vec2 LOOP
      null;
  END LOOP;
  RETURN 0;  
END; 

/* Пакет */
CREATE OR REPLACE PACKAGE Pack_Few_Fors
AS 
   FUNCTION PF_Few_Fors 
   RETURN PLS_INTEGER;
   PROCEDURE PP_Few_Fors; 
END; 

/* Тело пакета */
CREATE OR REPLACE PACKAGE BODY Pack_Few_Fors
AS 
   FUNCTION PF_Few_Fors
   RETURN PLS_INTEGER
   IS
     TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
     vec1 intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34);
     TYPE varray_t IS VARRAY(4) OF VARCHAR2(15);
     vec2 varray_t := varray_t('John', 'Mary', 'Alberto', 'Juanita');
   BEGIN
     FOR i, j IN PAIRS OF vec1 LOOP
       null;
     END LOOP;
     FOR i, j IN PAIRS OF vec2 LOOP
      null;
     END LOOP;
     RETURN 0;
   END;

   PROCEDURE PP_Few_Fors
   IS
     TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
     vec1 intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34);
     TYPE varray_t IS VARRAY(4) OF VARCHAR2(15);
     vec2 varray_t := varray_t('John', 'Mary', 'Alberto', 'Juanita');
   BEGIN
     FOR i, j IN PAIRS OF vec1 LOOP
       null;
     END LOOP;
     FOR i, j IN PAIRS OF vec2 LOOP
       null;
     END LOOP;
   END; 
END; 

/* Триггер DML */
CREATE OR REPLACE TRIGGER T_Few_Fors
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
  vec1 intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34);
  TYPE varray_t IS VARRAY(4) OF VARCHAR2(15);
  vec2 varray_t := varray_t('John', 'Mary', 'Alberto', 'Juanita');
BEGIN
  FOR i, j IN PAIRS OF vec1 LOOP
     null;
  END LOOP;
  FOR i, j IN PAIRS OF vec2 LOOP
      null;
  END LOOP;
END;

/* Анонимный блок */
DECLARE
  TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
  vec1 intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34);
  TYPE varray_t IS VARRAY(4) OF VARCHAR2(15);
  vec2 varray_t := varray_t('John', 'Mary', 'Alberto', 'Juanita');
BEGIN
  FOR i, j IN PAIRS OF vec1 LOOP
     null;
  END LOOP;
  FOR i, j IN PAIRS OF vec2 LOOP
      null;
  END LOOP;
END; 

