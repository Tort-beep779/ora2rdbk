CREATE PACKAGE PackF_Null_In_If
AS
   FUNCTION PF_Null_In_If 
   RETURN VARCHAR2;
END;

CREATE PACKAGE BODY PackF_Null_In_If
AS
   FUNCTION PF_Null_In_If
   RETURN VARCHAR2
   IS
     i PLS_INTEGER := 10;
     j PLS_INTEGER;
   BEGIN
     IF i = 2 THEN
       NULL;
     ELSIF i = 3 THEN
       NULL;
     ELSIF i = 4 THEN
       j := 10;
       NULL;
     ELSE NULL;
     END IF;
     NULL;
     RETURN '';
   END;
END;