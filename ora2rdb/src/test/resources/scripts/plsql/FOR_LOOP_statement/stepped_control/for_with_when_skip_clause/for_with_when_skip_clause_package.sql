CREATE OR REPLACE PACKAGE Pack_For_With_When
AS 
   FUNCTION PF_For_With_When
   RETURN PLS_INTEGER;
   PROCEDURE PP_For_With_When; 
END; 

CREATE OR REPLACE PACKAGE BODY Pack_For_With_When
AS 
   FUNCTION PF_For_With_When
   RETURN PLS_INTEGER
   IS
     summa PLS_INTEGER := 0;
   BEGIN
     FOR i IN 1..3 WHEN i != 2
     LOOP
      summa := summa + i;
     END LOOP;
     RETURN summa;
   END;

   PROCEDURE PP_For_With_When
   IS
     summa PLS_INTEGER := 0;
   BEGIN
     FOR i IN 1..3 WHEN i != 2
     LOOP
      summa := summa + i;
     END LOOP;
   END; 
END; 