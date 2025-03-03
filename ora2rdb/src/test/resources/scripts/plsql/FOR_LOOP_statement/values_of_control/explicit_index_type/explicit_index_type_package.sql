CREATE OR REPLACE PACKAGE Pack_Explicit_Index
AS 
   FUNCTION PF_Explicit_Index
   RETURN NUMBER;
   PROCEDURE PP_Explicit_Index; 
END; 

CREATE OR REPLACE PACKAGE BODY Pack_Explicit_Index
AS 
   FUNCTION PF_Explicit_Index
   RETURN NUMBER
   IS
     TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
     vec intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34);
     summa NUMBER(5,1) := 0;
   BEGIN
     FOR n NUMBER(5,1) IN VALUES OF vec
     LOOP
       summa := summa + n; 
     END LOOP;
     RETURN summa;
   END;

   PROCEDURE PP_Explicit_Index
   IS
     TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
     vec intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34);
     summa NUMBER(5,1)  := 0;
   BEGIN
     FOR n NUMBER(5,1) IN VALUES OF vec
     LOOP
       summa := summa + n; 
     END LOOP;
   END; 
END; 