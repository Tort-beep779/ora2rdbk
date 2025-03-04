CREATE FUNCTION CALLING_FUNCTION
RETURN NUMBER
IS
    cursor_variable pkg.cursor_type;
    return_value_from_function NUMBER;
BEGIN
    return_value_from_function := FUNCTION_NAME(cursor_variable); -- call function
    RETURN 1;
END;