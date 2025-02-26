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
     TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
     vec intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34);
     summa PLS_INTEGER := 0;
   BEGIN
     FOR i IN VALUES OF vec WHILE i < 20
     LOOP
       summa := summa + i;
     END LOOP;
     RETURN summa;
   END;

   PROCEDURE PP_For_With_While
   IS
     TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
     vec intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34);
     summa PLS_INTEGER := 0;
   BEGIN
     FOR i IN VALUES OF vec WHILE i < 20
     LOOP
       summa := summa + i;
     END LOOP;
   END; 
END; 