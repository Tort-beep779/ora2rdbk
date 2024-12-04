CREATE OR ALTER PROCEDURE another_procedure
    SQL SECURITY DEFINER
    AS
BEGIN
     RDB$TRACE_MSG('procedure triggered', false);
END;