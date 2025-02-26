CREATE OR REPLACE PACKAGE Pack_For_With_Label
AS 
   FUNCTION PF_For_With_Label
   RETURN PLS_INTEGER;
   PROCEDURE PP_For_With_Label; 
END; 

CREATE OR REPLACE PACKAGE BODY Pack_For_With_Label
AS 
   FUNCTION PF_For_With_Label
   RETURN PLS_INTEGER
   IS
     summa PLS_INTEGER := 0;
   BEGIN
     <<forlabel>>
     FOR i IN 1..3  
     LOOP
       summa := summa + i;
     END LOOP forlabel;
     RETURN summa;
   END;

   PROCEDURE PP_For_With_Label
   IS
     summa PLS_INTEGER := 0;
   BEGIN
     <<forlabel>>
     FOR i IN 1..3 
     LOOP
       summa := summa + i;
     END LOOP forlabel;
   END; 
END; 