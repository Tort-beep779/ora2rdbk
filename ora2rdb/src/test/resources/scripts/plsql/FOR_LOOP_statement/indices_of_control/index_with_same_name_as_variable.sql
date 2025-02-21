/* Процедура */
CREATE PROCEDURE P_Same_Name_Var
IS
  TYPE varray_t IS VARRAY(4) OF VARCHAR2(15);
  vec varray_t := varray_t('John', 'Mary', 'Alberto', 'Juanita');
  summa PLS_INTEGER := 0;
  i PLS_INTEGER;
BEGIN
  FOR i IN INDICES OF vec LOOP
      summa := summa + i;
  END LOOP;
  i := 100;
  summa := summa + i;
END; 

/* Функция */
CREATE FUNCTION F_Same_Name_Var
RETURN VARCHAR2(100)
IS
  TYPE varray_t IS VARRAY(4) OF VARCHAR2(15);
  vec varray_t := varray_t('John', 'Mary', 'Alberto', 'Juanita');
  summa PLS_INTEGER := 0;
  i PLS_INTEGER;
BEGIN
  FOR i IN INDICES OF vec LOOP
      summa := summa + i;
  END LOOP;
  i := 100;
  summa := summa + i;
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
     summa PLS_INTEGER := 0;
     i PLS_INTEGER;
   BEGIN
     FOR i IN INDICES OF vec LOOP
       summa := summa + i;
     END LOOP;
     i := 100;
     summa := summa + i;
     RETURN summa;
   END;

   PROCEDURE PP_Same_Name_Var
   IS
     TYPE varray_t IS VARRAY(4) OF VARCHAR2(15);
     vec varray_t := varray_t('John', 'Mary', 'Alberto', 'Juanita');
     summa PLS_INTEGER := 0;
     i PLS_INTEGER;
   BEGIN
     FOR i IN INDICES OF vec LOOP
       summa := summa + i;
     END LOOP;
     i := 100;
     summa := summa + i;
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
  summa PLS_INTEGER := 0;
  i PLS_INTEGER;
BEGIN
  FOR i IN INDICES OF vec LOOP
      summa := summa + i;
  END LOOP;
  i := 100;
  summa := summa + i;
END;

/* Анонимный блок */
DECLARE
  TYPE varray_t IS VARRAY(4) OF VARCHAR2(15);
  vec varray_t := varray_t('John', 'Mary', 'Alberto', 'Juanita');
  summa PLS_INTEGER := 0;
  i PLS_INTEGER;
BEGIN
  FOR i IN INDICES OF vec LOOP
      summa := summa + i;
  END LOOP;
  i := 100;
  summa := summa + i;
END; 