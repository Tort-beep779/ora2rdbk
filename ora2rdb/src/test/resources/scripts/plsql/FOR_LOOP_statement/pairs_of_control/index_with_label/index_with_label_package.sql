CREATE OR REPLACE PACKAGE Pack_Index_With_Label
AS 
   FUNCTION PF_Index_With_Label
   RETURN VARCHAR2(100);
   PROCEDURE PP_Index_With_Label; 
END; 

CREATE OR REPLACE PACKAGE BODY Pack_Index_With_Label
AS 
   FUNCTION PF_Index_With_Label
   RETURN VARCHAR2(100)
   IS
     TYPE nesttabl_t IS TABLE OF VARCHAR2(15);
     vec nesttabl_t := nesttabl_t('John', 'Mary', 'Alberto', 'Juanita');
     summa PLS_INTEGER := 0;
   BEGIN
     <<forlabel>>
     FOR i, j IN PAIRS OF vec LOOP
       summa := summa + forlabel.i;
     END LOOP forlabel;
     RETURN summa;
   END;

   PROCEDURE PP_Index_With_Label
   IS
     TYPE nesttabl_t IS TABLE OF VARCHAR2(15);
     vec nesttabl_t := nesttabl_t('John', 'Mary', 'Alberto', 'Juanita');
     summa PLS_INTEGER := 0;
   BEGIN
     <<forlabel>>
     FOR i, j IN PAIRS OF vec LOOP
       summa := summa + forlabel.i;
     END LOOP forlabel;
   END; 
END; 