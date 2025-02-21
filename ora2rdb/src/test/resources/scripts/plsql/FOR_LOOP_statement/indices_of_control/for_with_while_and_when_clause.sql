/* Процедура */
CREATE PROCEDURE P_For_With_While_and_When
IS
  TYPE varray_t IS VARRAY(4) OF VARCHAR2(15);
  vec varray_t := varray_t('John', 'Mary', 'Alberto', 'Juanita');
  summa INTEGER := 0;
BEGIN
  FOR i IN INDICES OF vec WHILE i != 4 WHEN i != 2
  LOOP
     summa := summa + i;
  END LOOP;
END; 

/* Функция */
CREATE FUNCTION F_For_With_While_and_When
RETURN VARCHAR2(100)
IS
  TYPE varray_t IS VARRAY(4) OF VARCHAR2(15);
  vec varray_t := varray_t('John', 'Mary', 'Alberto', 'Juanita');
  summa INTEGER := 0;
BEGIN
  FOR i IN INDICES OF vec WHILE i != 4 WHEN i != 2
  LOOP
     summa := summa + i;
  END LOOP;
  RETURN summa;  -- 8
END; 

/* Пакет */
CREATE OR REPLACE PACKAGE Pack_For_With_While_and_When
AS 
   FUNCTION PF_For_With_While_and_When
   RETURN VARCHAR2(100);
   PROCEDURE PP_For_With_While_and_When; 
END; 

/* Тело пакета */
CREATE OR REPLACE PACKAGE BODY Pack_For_With_While_and_When
AS 
   FUNCTION PF_For_With_While_and_When
   RETURN VARCHAR2(100)
   IS
     TYPE varray_t IS VARRAY(4) OF VARCHAR2(15);
     vec varray_t := varray_t('John', 'Mary', 'Alberto', 'Juanita');
     summa INTEGER := 0;
   BEGIN
     FOR i IN INDICES OF vec WHILE i != 4 WHEN i != 2
     LOOP
       summa := summa + i;
     END LOOP;
     RETURN summa;
   END;

   PROCEDURE PP_For_With_While_and_When
   IS
     TYPE varray_t IS VARRAY(4) OF VARCHAR2(15);
     vec varray_t := varray_t('John', 'Mary', 'Alberto', 'Juanita');
     summa INTEGER := 0;
   BEGIN
     FOR i IN INDICES OF vec WHILE i != 4 WHEN i != 2
     LOOP
       summa := summa + i;
     END LOOP;
   END;
END; 

/* Триггер DML */
CREATE OR REPLACE TRIGGER T_For_With_While_and_When
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  TYPE varray_t IS VARRAY(4) OF VARCHAR2(15);
  vec varray_t := varray_t('John', 'Mary', 'Alberto', 'Juanita');
  summa INTEGER := 0;
BEGIN
  FOR i IN INDICES OF vec WHILE i != 4 WHEN i != 2
  LOOP
     summa := summa + i;
  END LOOP;
END;

/* Анонимный блок */
DECLARE
   TYPE varray_t IS VARRAY(4) OF VARCHAR2(15);
   vec varray_t := varray_t('John', 'Mary', 'Alberto', 'Juanita');
   summa INTEGER := 0;
BEGIN
   FOR i IN INDICES OF vec WHILE i != 4 WHEN i != 2
   LOOP
      summa := summa + i;
   END LOOP;
END;