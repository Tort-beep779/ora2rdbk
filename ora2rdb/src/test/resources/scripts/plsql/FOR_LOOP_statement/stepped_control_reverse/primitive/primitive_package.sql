CREATE OR REPLACE PACKAGE Pack_Primitive
AS 
   FUNCTION PF_Primitive 
   RETURN PLS_INTEGER;
   PROCEDURE PP_Primitive; 
END; 

CREATE OR REPLACE PACKAGE BODY Pack_Primitive
AS 
   FUNCTION PF_Primitive
   RETURN PLS_INTEGER
   IS
     summa PLS_INTEGER := 0;
     done CHAR(1) := 'F';
   BEGIN
     FOR i IN REVERSE 1..3 LOOP
      summa := summa + i;
      done := 'T';
     END LOOP;
     RETURN summa;
   END;

   PROCEDURE PP_Primitive
   IS
     summa PLS_INTEGER := 0;
     done CHAR(1) := 'F';
   BEGIN
     FOR i IN REVERSE 1..3 LOOP
      summa := summa + i;
      done := 'T';
     END LOOP;
   END; 
END; 