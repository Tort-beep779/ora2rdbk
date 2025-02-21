/* Процедура */
CREATE PROCEDURE P_From_Nested_table
IS
  TYPE nesttabl_t IS TABLE OF VARCHAR2(15);
  vec nesttabl_t := nesttabl_t('John', 'Mary', 'Alberto', 'Juanita');
  summa VARCHAR2(100) := '';
BEGIN
   FOR i IN VALUES OF vec LOOP
      summa := summa || i;
   END LOOP;
END;

/* Функция */
CREATE FUNCTION F_From_Nested_table
RETURN VARCHAR2(100)
IS
   TYPE nesttabl_t IS TABLE OF VARCHAR2(15);
   vec nesttabl_t := nesttabl_t('John', 'Mary', 'Alberto', 'Juanita');
   summa VARCHAR2(100) := '';
BEGIN
   FOR i IN VALUES OF vec LOOP
      summa := summa || i;
   END LOOP;
END;

/* Пакет */
CREATE OR REPLACE PACKAGE Pack_From_Nested_table
AS 
   FUNCTION PF_From_Nested_table
   RETURN VARCHAR2(100);
   PROCEDURE PP_From_Nested_table; 
END; 

/* Тело пакета */
CREATE OR REPLACE PACKAGE BODY Pack_From_Nested_table
AS 
   FUNCTION PF_From_Nested_table
   RETURN VARCHAR2(100)
   IS
     TYPE nesttabl_t IS TABLE OF VARCHAR2(15);
     vec nesttabl_t := nesttabl_t('John', 'Mary', 'Alberto', 'Juanita');
     summa VARCHAR2(100) := '';
   BEGIN
     FOR i IN VALUES OF vec LOOP
       summa := summa || i;
     END LOOP;
     RETURN summa;
   END;

   PROCEDURE PP_From_Nested_table
   IS
     TYPE nesttabl_t IS TABLE OF VARCHAR2(15);
     vec nesttabl_t := nesttabl_t('John', 'Mary', 'Alberto', 'Juanita');
     summa VARCHAR2(100) := '';
   BEGIN
     FOR i IN VALUES OF vec LOOP
       summa := summa || i;
     END LOOP;
   END;
END;  

/* Триггер DML */
CREATE OR REPLACE TRIGGER T_From_Nested_table
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
   TYPE nesttabl_t IS TABLE OF VARCHAR2(15);
   vec nesttabl_t := nesttabl_t('John', 'Mary', 'Alberto', 'Juanita');
   summa VARCHAR2(100) := '';
BEGIN
   FOR i IN VALUES OF vec LOOP
      summa := summa || i;
   END LOOP;
END;

/* Анонимный блок */
DECLARE
   TYPE nesttabl_t IS TABLE OF VARCHAR2(15);
   vec nesttabl_t := nesttabl_t('John', 'Mary', 'Alberto', 'Juanita');
   summa VARCHAR2(100) := '';
BEGIN
   FOR i IN VALUES OF vec LOOP
      summa := summa || i;
   END LOOP;
END;

