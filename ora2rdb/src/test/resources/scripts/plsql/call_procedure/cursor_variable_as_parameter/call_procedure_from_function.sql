CREATE FUNCTION CALLING_FUNCTION
RETURN NUMBER
    IS
    cursor_variable pkg.cursor_type;
BEGIN
    PROCEDURE_NAME(cursor_variable); -- call procedure
END;