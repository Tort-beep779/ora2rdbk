CREATE PROCEDURE CALLING_PROCEDURE
IS
    value_in_function VARCHAR2(50);
    value_from_function VARCHAR2(50);
BEGIN
    value_in_function := 'value';
    value_from_function := FUNCTION_NAME(value_in_function); -- call function
END;