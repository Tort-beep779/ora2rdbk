CREATE PACKAGE PackF_Continue
AS
   FUNCTION PF_Continue 
   RETURN VARCHAR2;
END;

CREATE PACKAGE BODY PackF_Continue
AS
   FUNCTION PF_Continue
   RETURN VARCHAR2
   IS
   BEGIN
     FOR i IN 1..3 LOOP
       if i = 1 then 
         CONTINUE;
       end if;  
     END LOOP;
     RETURN '';
   END;
END;