CREATE OR ALTER PROCEDURE procedure_name
    SQL SECURITY DEFINER
    AS
BEGIN
   RDB$TRACE_MSG('some text' , false);
END;