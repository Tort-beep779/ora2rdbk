CREATE OR REPLACE PACKAGE Pack_From_Varray
AS 
   FUNCTION PF_From_Varray
   RETURN VARCHAR2(100);
   PROCEDURE PP_From_Varray; 
END; 

CREATE OR REPLACE PACKAGE BODY Pack_From_Varray
AS 
   FUNCTION PF_From_Varray
   RETURN VARCHAR2(100)
   IS
     TYPE varray_t IS VARRAY(4) OF VARCHAR2(15);
     vec varray_t := varray_t('John', 'Mary', 'Alberto', 'Juanita');
     summa PLS_INTEGER := 0;
   BEGIN
     FOR i IN INDICES OF vec LOOP
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
     FOR i IN INDICES OF vec LOOP
       summa := summa + i;
     END LOOP;
   END;
END;  