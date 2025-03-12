CREATE PACKAGE PackF_Exit_Label
AS
   FUNCTION PF_Exit_Label 
   RETURN VARCHAR2;
END;

CREATE PACKAGE BODY PackF_Exit_Label
AS
   FUNCTION PF_Exit_Label
   RETURN VARCHAR2
   IS
     x NUMBER := 0;
   BEGIN
     <<loop1>>
     LOOP
       x := x + 1;
       IF x > 4 THEN
         EXIT loop1;
       END IF;
     END LOOP;
     RETURN '';
   END;
END;