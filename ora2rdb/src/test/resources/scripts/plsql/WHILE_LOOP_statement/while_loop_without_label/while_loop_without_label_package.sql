CREATE OR REPLACE PACKAGE Pack_While
AS 
   FUNCTION PF_While 
   RETURN VARCHAR2;
   PROCEDURE PP_While; 
END Pack_While; 

CREATE OR REPLACE PACKAGE BODY Pack_While
AS 
   FUNCTION PF_While 
   RETURN VARCHAR2
   IS
     done BOOLEAN := FALSE;
     res VARCHAR2(50) := '';
   BEGIN
     WHILE done LOOP
       res := 'This line does not print.';
     END LOOP;
     WHILE (NOT done) LOOP
       done := TRUE;
       res := 'Hello, world!';
     END LOOP;
     WHILE NOT done LOOP
       res := 'This line does not print.';
     END LOOP;
     RETURN res;
   END;

   PROCEDURE PP_While
   IS
     done BOOLEAN := FALSE;
     res VARCHAR2(50) := '';
   BEGIN
     WHILE done LOOP
       res := 'This line does not print.';
     END LOOP;
     WHILE (NOT done) LOOP
       done := TRUE;
       res := 'Hello, world!';
     END LOOP;
     WHILE NOT done LOOP
       res := 'This line does not print.';
     END LOOP;
   END; 
END Pack_While; 