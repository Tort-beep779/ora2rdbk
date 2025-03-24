CREATE OR REPLACE PACKAGE Pack_Same_Name_Var
AS 
   FUNCTION PF_Same_Name_Var
   RETURN PLS_INTEGER;
   PROCEDURE PP_Same_Name_Var; 
END; 

CREATE OR REPLACE PACKAGE BODY Pack_Same_Name_Var
AS 
   FUNCTION PF_Same_Name_Var
   RETURN PLS_INTEGER
   IS
     summa PLS_INTEGER := 0;
     i PLS_INTEGER;
   BEGIN
     FOR i IN 1..3 LOOP
      summa := summa + i;
     END LOOP;
     i := 10;
     summa := summa + i;
     RETURN summa;
   END;

   PROCEDURE PP_Same_Name_Var
   IS
     summa PLS_INTEGER := 0;
     i PLS_INTEGER;
   BEGIN
     FOR i IN 1..3 LOOP
       summa := summa + i;
     END LOOP;
     i := 10;
     summa := summa + i;
   END; 
END; 