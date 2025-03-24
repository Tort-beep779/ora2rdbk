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
     summa PLS_INTEGER := 0;
   BEGIN
     FOR i IN REVERSE 1..3 LOOP
       FOR n IN REVERSE 1..3 LOOP
         summa := summa + i*n; 
       END LOOP;
     END LOOP;
     RETURN summa;
   END;

   PROCEDURE PP_Nested_Fors
   IS
     summa PLS_INTEGER := 0;
   BEGIN
     FOR i IN REVERSE 1..3 LOOP
       FOR n IN REVERSE 1..3 LOOP
         summa := summa + i*n; 
       END LOOP;
     END LOOP;
   END; 
END; 