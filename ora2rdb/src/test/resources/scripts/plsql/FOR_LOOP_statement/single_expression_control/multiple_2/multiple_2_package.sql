CREATE OR REPLACE PACKAGE Pack_Multiple2
AS 
   FUNCTION PF_Multiple2
   RETURN PLS_INTEGER;
   PROCEDURE PP_Multiple2; 
END; 

CREATE OR REPLACE PACKAGE BODY Pack_Multiple2
AS 
   FUNCTION PF_Multiple2
   RETURN PLS_INTEGER
   IS
     summa PLS_INTEGER := 0;
   BEGIN
     FOR i IN 1..3 WHEN i < 3, i
     LOOP
       summa := summa + i;
     END LOOP;
     RETURN summa;
   END;

   PROCEDURE PP_Multiple2
   IS
     summa PLS_INTEGER := 0;
   BEGIN
     FOR i IN 1..3 WHEN i < 3, i
     LOOP
       summa := summa + i;
     END LOOP;
   END; 
END; 