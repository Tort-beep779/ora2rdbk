CREATE OR REPLACE PACKAGE Pack_For_With_While
AS 
   FUNCTION PF_For_With_While
   RETURN PLS_INTEGER;
   PROCEDURE PP_For_With_While; 
END; 

CREATE OR REPLACE PACKAGE BODY Pack_For_With_While
AS 
   FUNCTION PF_For_With_While
   RETURN PLS_INTEGER
   IS
     summa PLS_INTEGER := 0;
   BEGIN
     FOR power IN 2, REPEAT power*2 WHILE power <= 64
     LOOP
       summa := summa + power;
     END LOOP;
     RETURN summa;
   END;

   PROCEDURE PP_For_With_While
   IS
     summa PLS_INTEGER := 0;
   BEGIN
     FOR power IN 2, REPEAT power*2 WHILE power <= 64
     LOOP
       summa := summa + power;
     END LOOP;
   END; 
END; 