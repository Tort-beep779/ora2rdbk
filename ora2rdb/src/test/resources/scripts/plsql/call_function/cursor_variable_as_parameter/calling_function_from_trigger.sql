CREATE TRIGGER TRIGGER_NAME
BEFORE INSERT ON EMPLOYEES
FOR EACH ROW
DECLARE
    cursor_variable pkg.cursor_type;
    return_value_from_function NUMBER;
BEGIN
     return_value_from_function := FUNCTION_NAME(cursor_variable); -- call function
END;