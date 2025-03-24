CREATE OR REPLACE PACKAGE Pack_From_Nested_table
AS 
   FUNCTION PF_From_Nested_table
   RETURN VARCHAR2(100);
   PROCEDURE PP_From_Nested_table; 
END; 

CREATE OR REPLACE PACKAGE BODY Pack_From_Nested_table
AS 
   FUNCTION PF_From_Nested_table
   RETURN VARCHAR2(100)
   IS
     TYPE nesttabl_t IS TABLE OF VARCHAR2(15);
     vec nesttabl_t := nesttabl_t('John', 'Mary', 'Alberto', 'Juanita');
     summa PLS_INTEGER := 0;
   BEGIN
     FOR i IN REVERSE INDICES OF vec LOOP
       summa := summa + i;
     END LOOP;
     RETURN summa;
   END;

   PROCEDURE PP_From_Nested_table
   IS
     TYPE nesttabl_t IS TABLE OF VARCHAR2(15);
     vec nesttabl_t := nesttabl_t('John', 'Mary', 'Alberto', 'Juanita');
     summa PLS_INTEGER := 0;
   BEGIN
     FOR i IN REVERSE INDICES OF vec LOOP
       summa := summa + i;
     END LOOP;
   END;
END;  