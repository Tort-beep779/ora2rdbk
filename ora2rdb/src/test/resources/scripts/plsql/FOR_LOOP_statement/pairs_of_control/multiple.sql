/* Процедура */
CREATE PROCEDURE P_multiple
IS
   TYPE varray_t1 IS VARRAY(5) OF VARCHAR2(15);
   vec1 varray_t1 := varray_t1('Olivia', 'William', 'Emma', 'Henry', 'Grace');
   TYPE nesttabl_t2 IS TABLE OF VARCHAR2(15);
   vec2 nesttabl_t2 := nesttabl_t2('John', 'Mary', 'Alberto', 'Juanita');
   summa PLS_INTEGER := 0;
BEGIN
   FOR i, j IN PAIRS OF vec1, PAIRS OF vec2
   LOOP
     summa := summa + i;
   END LOOP;
END; 

/* Функция */
CREATE FUNCTION F_multiple
RETURN PLS_INTEGER
IS
   TYPE varray_t1 IS VARRAY(5) OF VARCHAR2(15);
   vec1 varray_t1 := varray_t1('Olivia', 'William', 'Emma', 'Henry', 'Grace');
   TYPE nesttabl_t2 IS TABLE OF VARCHAR2(15);
   vec2 nesttabl_t2 := nesttabl_t2('John', 'Mary', 'Alberto', 'Juanita');
   summa PLS_INTEGER := 0;
BEGIN
   FOR i, j IN PAIRS OF vec1, PAIRS OF vec2
   LOOP
     summa := summa + i;
   END LOOP;
  RETURN summa;
END; 

/* Пакет */
CREATE OR REPLACE PACKAGE Pack_multiple
AS 
   FUNCTION PF_multiple
   RETURN PLS_INTEGER;
   PROCEDURE PP_multiple; 
END; 

/* Тело пакета */
CREATE OR REPLACE PACKAGE BODY Pack_multiple
AS 
   FUNCTION PF_multiple
   RETURN PLS_INTEGER
   IS
     TYPE varray_t1 IS VARRAY(5) OF VARCHAR2(15);
     vec1 varray_t1 := varray_t1('Olivia', 'William', 'Emma', 'Henry', 'Grace');
     TYPE nesttabl_t2 IS TABLE OF VARCHAR2(15);
     vec2 nesttabl_t2 := nesttabl_t2('John', 'Mary', 'Alberto', 'Juanita');
     summa PLS_INTEGER := 0;
   BEGIN
     FOR i, j IN PAIRS OF vec1, PAIRS OF vec2
     LOOP
       summa := summa + i;
     END LOOP;
     RETURN summa;
   END;

   PROCEDURE PP_multiple
   IS
     TYPE varray_t1 IS VARRAY(5) OF VARCHAR2(15);
     vec1 varray_t1 := varray_t1('Olivia', 'William', 'Emma', 'Henry', 'Grace');
     TYPE nesttabl_t2 IS TABLE OF VARCHAR2(15);
     vec2 nesttabl_t2 := nesttabl_t2('John', 'Mary', 'Alberto', 'Juanita');
     summa PLS_INTEGER := 0;
   BEGIN
     FOR i, j IN PAIRS OF vec1, PAIRS OF vec2
     LOOP
       summa := summa + i;
     END LOOP;
   END; 
END; 

/* Триггер DML */
CREATE OR REPLACE TRIGGER T_multiple
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
   TYPE varray_t1 IS VARRAY(5) OF VARCHAR2(15);
   vec1 varray_t1 := varray_t1('Olivia', 'William', 'Emma', 'Henry', 'Grace');
   TYPE nesttabl_t2 IS TABLE OF VARCHAR2(15);
   vec2 nesttabl_t2 := nesttabl_t2('John', 'Mary', 'Alberto', 'Juanita');
   summa PLS_INTEGER := 0;
BEGIN
   FOR i, j IN PAIRS OF vec1, PAIRS OF vec2
   LOOP
     summa := summa + i;
   END LOOP;
END;

/* Анонимный блок */
DECLARE
   TYPE varray_t1 IS VARRAY(5) OF VARCHAR2(15);
   vec1 varray_t1 := varray_t1('Olivia', 'William', 'Emma', 'Henry', 'Grace');
   TYPE nesttabl_t2 IS TABLE OF VARCHAR2(15);
   vec2 nesttabl_t2 := nesttabl_t2('John', 'Mary', 'Alberto', 'Juanita');
   summa PLS_INTEGER := 0;
BEGIN
   FOR i, j IN PAIRS OF vec1, PAIRS OF vec2
   LOOP
     summa := summa + i;
   END LOOP;
END;