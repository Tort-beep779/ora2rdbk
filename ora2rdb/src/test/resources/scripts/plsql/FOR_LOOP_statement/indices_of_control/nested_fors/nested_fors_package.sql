CREATE OR REPLACE PACKAGE Pack_Nested_Fors
AS 
   FUNCTION PF_Nested_Fors
   RETURN PLS_INTEGER;
   PROCEDURE PP_Nested_Fors; 
END; 

CREATE OR REPLACE PACKAGE BODY Pack_Nested_Fors
AS 
   FUNCTION PF_Nested_Fors
   RETURN PLS_INTEGER
   IS
     TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
     vec1 intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34);
     TYPE varray_t IS VARRAY(4) OF VARCHAR2(15);
     vec2 varray_t := varray_t('John', 'Mary', 'Alberto', 'Juanita');
   BEGIN
     FOR i IN INDICES OF vec1 LOOP
       FOR n IN INDICES OF vec2 LOOP
         null;
       END LOOP;
     END LOOP;
     RETURN 0;
   END;

   PROCEDURE PP_Nested_Fors
   IS
     TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
     vec1 intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34);
     TYPE varray_t IS VARRAY(4) OF VARCHAR2(15);
     vec2 varray_t := varray_t('John', 'Mary', 'Alberto', 'Juanita');
   BEGIN
     FOR i IN INDICES OF vec1 LOOP
       FOR n IN INDICES OF vec2 LOOP
         null;
       END LOOP;
     END LOOP;
   END; 
END; 