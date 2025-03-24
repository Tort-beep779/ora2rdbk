CREATE PACKAGE PackF_Goto
AS
   FUNCTION PF_Goto 
   RETURN VARCHAR2;
END;

CREATE PACKAGE BODY PackF_Goto
AS
   FUNCTION PF_Goto
   RETURN VARCHAR2
   IS
     i PLS_INTEGER;
   BEGIN
     GOTO first_label;
     i := 10; 
     <<first_label>>
     i := 1;
     RETURN '';
   END;
END;