CREATE PROCEDURE CALLING_PROCEDURE
IS
    value_from_function VARCHAR2(50);
BEGIN
   value_from_function := FUNCTION_NAME; -- call function
    value_from_function := FUNCTION_NAME(); -- call function
END;