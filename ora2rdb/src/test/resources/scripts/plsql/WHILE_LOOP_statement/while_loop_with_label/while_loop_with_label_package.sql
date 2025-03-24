CREATE OR REPLACE PACKAGE Pack_While_Label
AS 
   FUNCTION PF_While_Label 
   RETURN VARCHAR2;
   PROCEDURE PP_While_Label; 
END Pack_While_Label; 

CREATE OR REPLACE PACKAGE BODY Pack_While_Label
AS 
   FUNCTION PF_While_Label 
   RETURN VARCHAR2
   IS
     done BOOLEAN := FALSE;
     res VARCHAR2(50) := '';
   BEGIN
     <<loopA>>
     WHILE (NOT done) LOOP
       done := TRUE;
       res := 'Hello, world!';
     END LOOP loopA;
     RETURN res;
   END;

   PROCEDURE PP_While_Label
   IS
     done BOOLEAN := FALSE;
     res VARCHAR2(50) := '';
   BEGIN
     <<loopA>>
     WHILE (NOT done) LOOP
       done := TRUE;
       res := 'Hello, world!';
     END LOOP loopA;
   END; 
END Pack_While_Label; 