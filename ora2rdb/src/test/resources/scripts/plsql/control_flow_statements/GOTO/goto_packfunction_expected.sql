CREATE PACKAGE PackF_Goto
SQL SECURITY DEFINER
AS BEGIN
   FUNCTION PF_Goto 
   RETURNS VARCHAR(32765);
END;

CREATE PACKAGE BODY PackF_Goto
AS BEGIN
   FUNCTION PF_Goto
   RETURNS VARCHAR(32765)
   AS
   /*
     i PLS_INTEGER;
   */
   BEGIN
   /*
     GOTO first_label;
     i := 10; 
     <<first_label>>
     i := 1;
   */
   RETURN '';
   END
END;