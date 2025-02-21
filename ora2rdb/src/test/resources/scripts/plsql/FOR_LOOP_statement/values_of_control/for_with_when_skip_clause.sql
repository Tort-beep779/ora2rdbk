/* Процедура */
CREATE PROCEDURE P_For_With_When
IS
  TYPE nesttabl_t IS TABLE OF VARCHAR2(15);
  vec nesttabl_t := nesttabl_t('John', 'Mary', 'Alberto', 'Juanita');
  summa VARCHAR2(100) := '';
BEGIN
  FOR i IN VALUES OF vec WHEN i != 'Mary'
  LOOP
     summa := summa || i;
  END LOOP;
END; 

/* Функция */
CREATE FUNCTION F_For_With_When
RETURN VARCHAR2(100)
IS
  TYPE nesttabl_t IS TABLE OF VARCHAR2(15);
  vec nesttabl_t := nesttabl_t('John', 'Mary', 'Alberto', 'Juanita');
  summa VARCHAR2(100) := '';
BEGIN
  FOR i IN VALUES OF vec WHEN i != 'Mary'
  LOOP
     summa := summa || i;
  END LOOP;
  RETURN summa; 
END; 

/* Пакет */
CREATE OR REPLACE PACKAGE Pack_For_With_When
AS 
   FUNCTION PF_For_With_When
   RETURN VARCHAR2(100);
   PROCEDURE PP_For_With_When; 
END; 

/* Тело пакета */
CREATE OR REPLACE PACKAGE BODY Pack_For_With_When
AS 
   FUNCTION PF_For_With_When
   RETURN VARCHAR2(100)
   IS
     TYPE nesttabl_t IS TABLE OF VARCHAR2(15);
     vec nesttabl_t := nesttabl_t('John', 'Mary', 'Alberto', 'Juanita');
     summa VARCHAR2(100) := '';
   BEGIN
     FOR i IN VALUES OF vec WHEN i != 'Mary'
     LOOP
       summa := summa || i;
     END LOOP;
     RETURN summa;
   END;

   PROCEDURE PP_For_With_When
   IS
     TYPE nesttabl_t IS TABLE OF VARCHAR2(15);
     vec nesttabl_t := nesttabl_t('John', 'Mary', 'Alberto', 'Juanita');
     summa VARCHAR2(100) := '';
   BEGIN
     FOR i IN VALUES OF vec WHEN i != 'Mary'
     LOOP
       summa := summa || i;
     END LOOP;
   END; 
END; 

/* Триггер DML */
CREATE OR REPLACE TRIGGER T_For_With_When
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  TYPE nesttabl_t IS TABLE OF VARCHAR2(15);
  vec nesttabl_t := nesttabl_t('John', 'Mary', 'Alberto', 'Juanita');
  summa VARCHAR2(100) := '';
BEGIN
  FOR i IN VALUES OF vec WHEN i != 'Mary'
  LOOP
     summa := summa || i;
  END LOOP;
END;

/* Анонимный блок */
DECLARE
   TYPE nesttabl_t IS TABLE OF VARCHAR2(15);
   vec nesttabl_t := nesttabl_t('John', 'Mary', 'Alberto', 'Juanita');
   summa VARCHAR2(100) := '';
BEGIN
   FOR i IN VALUES OF vec WHEN i != 'Mary'
   LOOP
      summa := summa || i;
   END LOOP;
END;
