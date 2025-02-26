CREATE OR REPLACE PACKAGE Pack_For_With_Step
AS 
   FUNCTION PF_For_With_Step
   RETURN PLS_INTEGER;
   PROCEDURE PP_For_With_Step; 
END; 

CREATE OR REPLACE PACKAGE BODY Pack_For_With_Step
AS 
   FUNCTION PF_For_With_Step
   RETURN PLS_INTEGER
   IS
     summa PLS_INTEGER := 0;
   BEGIN
     FOR i IN 5..15 BY 5 
     LOOP
       summa := summa + i;
     END LOOP;
     RETURN summa;
   END;

   PROCEDURE PP_For_With_Step
   IS
     summa PLS_INTEGER := 0;
   BEGIN
     FOR i IN 5..15 BY 5 
     LOOP
       summa := summa + i;
     END LOOP;
   END; 
END; 