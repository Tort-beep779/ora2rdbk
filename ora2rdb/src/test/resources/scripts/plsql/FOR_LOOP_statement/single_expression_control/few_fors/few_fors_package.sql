CREATE OR REPLACE PACKAGE Pack_Few_Fors
AS 
   FUNCTION PF_Few_Fors 
   RETURN PLS_INTEGER;
   PROCEDURE PP_Few_Fors; 
END; 

CREATE OR REPLACE PACKAGE BODY Pack_Few_Fors
AS 
   FUNCTION PF_Few_Fors
   RETURN PLS_INTEGER
   IS
     summa PLS_INTEGER := 0;
   BEGIN
     FOR i IN 1..3 LOOP
       summa := summa + i;
     END LOOP;
     FOR i IN REPEAT 1 while summa < 10
     LOOP
       summa := summa + i;
     END LOOP;
     RETURN summa;
   END;

   PROCEDURE PP_Few_Fors
   IS
     summa PLS_INTEGER := 0;
   BEGIN
     FOR i IN 1..3 LOOP
       summa := summa + i;
     END LOOP;
     FOR i IN REPEAT 1 while summa < 10
     LOOP
      summa := summa + i;
     END LOOP;
   END; 
END; 