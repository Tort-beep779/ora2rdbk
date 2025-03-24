CREATE OR REPLACE PACKAGE Pack_Expr_Bounds
AS 
   FUNCTION PF_Expr_Bounds
   RETURN PLS_INTEGER;
   PROCEDURE PP_Expr_Bounds; 
END; 

CREATE OR REPLACE PACKAGE BODY Pack_Expr_Bounds
AS 
   FUNCTION PF_Expr_Bounds
   RETURN PLS_INTEGER
   IS
     summa PLS_INTEGER := 0;
     power PLS_INTEGER;
   BEGIN
     power := 7;
     FOR i IN REPEAT power+1 while power < 20
     LOOP
       summa := summa + i;
       power := power + 1;
     END LOOP;
     RETURN summa;
   END;

   PROCEDURE PP_Expr_Bounds
   IS
     summa PLS_INTEGER := 0;
     power PLS_INTEGER;
   BEGIN
     power := 7;
     FOR i IN REPEAT power+1 while power < 20
     LOOP
       summa := summa + i;
       power := power + 1;
     END LOOP;
   END; 
END; 