CREATE PROCEDURE CALLING_PROCEDURE
    IS
    cursor_variable pkg.cursor_type;
BEGIN
    PROCEDURE_NAME(cursor_variable); -- call procedure
END;
