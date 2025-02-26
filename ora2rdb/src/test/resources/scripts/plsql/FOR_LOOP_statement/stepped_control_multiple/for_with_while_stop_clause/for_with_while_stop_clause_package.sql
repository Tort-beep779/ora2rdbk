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
     FOR i IN 1..3 WHILE i != 2, REVERSE 1..3 WHILE i != 2
     LOOP
      summa := summa + i;
     END LOOP;
     RETURN summa;
   END;

   PROCEDURE PP_For_With_While
   IS
     summa PLS_INTEGER := 0;
   BEGIN
     FOR i IN 1..3 WHILE i != 2, REVERSE 1..3 WHILE i != 2
     LOOP
      summa := summa + i;
     END LOOP;
   END; 
END; 