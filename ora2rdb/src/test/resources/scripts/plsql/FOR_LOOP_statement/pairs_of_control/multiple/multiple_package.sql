CREATE OR REPLACE PACKAGE Pack_multiple
AS 
   FUNCTION PF_multiple
   RETURN PLS_INTEGER;
   PROCEDURE PP_multiple; 
END; 

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