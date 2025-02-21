/* Процедура */
CREATE PROCEDURE P_Same_Name_Var
IS
  TYPE varray_t IS VARRAY(4) OF VARCHAR2(15);
  vec varray_t := varray_t('John', 'Mary', 'Alberto', 'Juanita');
  summa VARCHAR2(100) := '';
  i VARCHAR2(15);
  j VARCHAR2(15);
BEGIN
  FOR i, j IN PAIRS OF vec LOOP
      summa := summa || j;
  END LOOP;
  i := 'Jon';
  j := 'Rose';
  summa := summa || i || j;
END; 

/* Функция */
CREATE FUNCTION F_Same_Name_Var
RETURN VARCHAR2(100)
IS
  TYPE varray_t IS VARRAY(4) OF VARCHAR2(15);
  vec varray_t := varray_t('John', 'Mary', 'Alberto', 'Juanita');
  summa VARCHAR2(100) := '';
  i VARCHAR2(15);
  j VARCHAR2(15);
BEGIN
  FOR i, j IN PAIRS OF vec LOOP
      summa := summa || j;
  END LOOP;
  i := 'Jon';
  j := 'Rose';
  summa := summa || i || j;
  RETURN summa; 
END; 

/* Пакет */
CREATE OR REPLACE PACKAGE Pack_Same_Name_Var
AS 
   FUNCTION PF_Same_Name_Var
   RETURN VARCHAR2(100);
   PROCEDURE PP_Same_Name_Var; 
END; 

/* Тело пакета */
CREATE OR REPLACE PACKAGE BODY Pack_Same_Name_Var
AS 
   FUNCTION PF_Same_Name_Var
   RETURN VARCHAR2(100)
   IS
     TYPE varray_t IS VARRAY(4) OF VARCHAR2(15);
     vec varray_t := varray_t('John', 'Mary', 'Alberto', 'Juanita');
     summa VARCHAR2(100) := '';
     i VARCHAR2(15);
     j VARCHAR2(15);
   BEGIN
     FOR i, j IN PAIRS OF vec LOOP
       summa := summa || j;
     END LOOP;
     i := 'Jon';
     j := 'Rose';
     summa := summa || i || j;
     RETURN summa;
   END;

   PROCEDURE PP_Same_Name_Var
   IS
     TYPE varray_t IS VARRAY(4) OF VARCHAR2(15);
     vec varray_t := varray_t('John', 'Mary', 'Alberto', 'Juanita');
     summa VARCHAR2(100) := '';
     i VARCHAR2(15);
     j VARCHAR2(15);
   BEGIN
     FOR i, j IN PAIRS OF vec LOOP
       summa := summa || j;
     END LOOP;
     i := 'Jon';
     j := 'Rose';
     summa := summa || i || j;
   END; 
END; 

/* Триггер DML */
CREATE OR REPLACE TRIGGER T_Same_Name_Var
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  TYPE varray_t IS VARRAY(4) OF VARCHAR2(15);
  vec varray_t := varray_t('John', 'Mary', 'Alberto', 'Juanita');
  summa VARCHAR2(100) := '';
  i VARCHAR2(15);
  j VARCHAR2(15);
BEGIN
  FOR i, j IN PAIRS OF vec LOOP
      summa := summa || j;
  END LOOP;
  i := 'Jon';
  j := 'Rose';
  summa := summa || i || j;
END;

/* Анонимный блок */
DECLARE
  TYPE varray_t IS VARRAY(4) OF VARCHAR2(15);
  vec varray_t := varray_t('John', 'Mary', 'Alberto', 'Juanita');
  summa VARCHAR2(100) := '';
  i VARCHAR2(15);
  j VARCHAR2(15);
BEGIN
  FOR i, j IN PAIRS OF vec LOOP
      summa := summa || j;
  END LOOP;
  i := 'Jon';
  j := 'Rose';
  summa := summa || i || j;
END; 