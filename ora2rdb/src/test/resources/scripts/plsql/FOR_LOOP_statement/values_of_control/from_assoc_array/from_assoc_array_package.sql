CREATE OR REPLACE PACKAGE Pack_From_Assoc_Array
AS 
   FUNCTION PF_From_Assoc_Array
   RETURN PLS_INTEGER;
   PROCEDURE PP_From_Assoc_Array; 
END; 

CREATE OR REPLACE PACKAGE BODY Pack_From_Assoc_Array
AS 
   FUNCTION PF_From_Assoc_Array
   RETURN PLS_INTEGER
   IS
     summa PLS_INTEGER := 0;
     TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
     vec intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34);
   BEGIN
     FOR i IN VALUES OF vec LOOP
      summa := summa + i;   
     END LOOP;
     RETURN summa;
   END;

   PROCEDURE PP_From_Assoc_Array
   IS
     summa PLS_INTEGER := 0;
     TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
     vec intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34);
   BEGIN
     FOR i IN VALUES OF vec LOOP
      summa := summa + i; 
     END LOOP;
   END; 
END; 