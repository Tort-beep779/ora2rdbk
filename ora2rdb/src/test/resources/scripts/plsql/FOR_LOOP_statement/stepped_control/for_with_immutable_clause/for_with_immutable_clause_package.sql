CREATE OR REPLACE PACKAGE Pack_For_With_Immutable_Index
AS 
   FUNCTION PF_For_With_Immutable_Index
   RETURN PLS_INTEGER;
   PROCEDURE PP_For_With_Immutable_Index; 
END; 

CREATE OR REPLACE PACKAGE BODY Pack_For_With_Immutable_Index
AS 
   FUNCTION PF_For_With_Immutable_Index
   RETURN PLS_INTEGER
   IS
     summa PLS_INTEGER := 0;
   BEGIN
     FOR i IMMUTABLE IN 1..3 LOOP
       summa := summa + i;
     END LOOP;
     RETURN summa;
   END; 

   PROCEDURE PP_For_With_Immutable_Index
   IS
     summa PLS_INTEGER := 0;
   BEGIN
     FOR i IMMUTABLE IN 1..3 LOOP
       summa := summa + i;
     END LOOP;
   END; 
END; 