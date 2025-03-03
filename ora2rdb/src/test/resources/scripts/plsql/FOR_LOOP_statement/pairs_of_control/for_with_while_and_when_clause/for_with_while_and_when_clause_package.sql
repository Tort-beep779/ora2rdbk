CREATE OR REPLACE PACKAGE Pack_For_With_While_and_When
AS 
   FUNCTION PF_For_With_While_and_When
   RETURN VARCHAR2(100);
   PROCEDURE PP_For_With_While_and_When; 
END; 

CREATE OR REPLACE PACKAGE BODY Pack_For_With_While_and_When
AS 
   FUNCTION PF_For_With_While_and_When
   RETURN VARCHAR2(100)
   IS
     TYPE varray_t IS VARRAY(4) OF VARCHAR2(15);
     vec varray_t := varray_t('John', 'Mary', 'Alberto', 'Juanita');
     summa PLS_INTEGER := 0;
   BEGIN
     FOR i, j IN PAIRS OF vec WHILE i != 4 WHEN j != 'Mary'
     LOOP
       summa := summa + i;
     END LOOP;
     RETURN summa;
   END;

   PROCEDURE PP_For_With_While_and_When
   IS
     TYPE varray_t IS VARRAY(4) OF VARCHAR2(15);
     vec varray_t := varray_t('John', 'Mary', 'Alberto', 'Juanita');
     summa PLS_INTEGER := 0;
   BEGIN
     FOR i, j IN PAIRS OF vec WHILE i != 4 WHEN j != 'Mary'
     LOOP
       summa := summa + i;
     END LOOP;
   END;
END; 