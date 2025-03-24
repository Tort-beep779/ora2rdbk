CREATE PACKAGE PackF_Continue_Label
AS
   FUNCTION PF_Continue_Label 
   RETURN VARCHAR2;
END;

CREATE PACKAGE BODY PackF_Continue_Label
AS
   FUNCTION PF_Continue_Label
   RETURN VARCHAR2
   IS
     x NUMBER := 0;
   BEGIN
     <<loop1>>
     LOOP
       x := x + 1;
       IF x < 3 THEN
         CONTINUE loop1;
       END IF;
       EXIT WHEN x = 5;
     END LOOP;
     RETURN '';
   END;
END;