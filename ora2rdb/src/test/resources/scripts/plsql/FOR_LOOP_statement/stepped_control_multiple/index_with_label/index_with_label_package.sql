CREATE OR REPLACE PACKAGE Pack_Index_With_Label
AS 
   FUNCTION PF_Index_With_Label
   RETURN PLS_INTEGER;
   PROCEDURE PP_Index_With_Label; 
END; 

CREATE OR REPLACE PACKAGE BODY Pack_Index_With_Label
AS 
   FUNCTION PF_Index_With_Label
   RETURN PLS_INTEGER
   IS
     summa PLS_INTEGER := 0;
   BEGIN
     <<forlabel>>
     FOR i IN 1..3, REVERSE 1..3, 10..12 
     LOOP
       summa := summa + forlabel.i;
     END LOOP forlabel;
     RETURN summa;
   END;

   PROCEDURE PP_Index_With_Label
   IS
     summa PLS_INTEGER := 0;
   BEGIN
     <<forlabel>>
     FOR i IN 1..3, REVERSE 1..3, 10..12 
     LOOP
       summa := summa + forlabel.i;
     END LOOP forlabel;
   END; 
END; 