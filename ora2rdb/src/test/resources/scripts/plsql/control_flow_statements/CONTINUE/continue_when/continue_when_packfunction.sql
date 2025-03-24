CREATE PACKAGE PackF_Continue_When
AS
   FUNCTION PF_Continue_When 
   RETURN VARCHAR2;
END;

CREATE PACKAGE BODY PackF_Continue_When
AS
   FUNCTION PF_Continue_When
   RETURN VARCHAR2
   IS
   BEGIN
     FOR i IN 1..3 LOOP
       CONTINUE WHEN i = 1;  
     END LOOP;
     RETURN '';
   END;
END;