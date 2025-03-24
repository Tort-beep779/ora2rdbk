CREATE PACKAGE PackF_Exit
AS
   FUNCTION PF_Exit 
   RETURN VARCHAR2;
END;

CREATE PACKAGE BODY PackF_Exit
AS
   FUNCTION PF_Exit
   RETURN VARCHAR2
   IS
   BEGIN
     FOR i IN 1..3 LOOP
       if i = 3 then 
         EXIT;
       end if;  
     END LOOP;
     RETURN '';
   END;
END;