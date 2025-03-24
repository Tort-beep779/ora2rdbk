CREATE PROCEDURE CALLING_PROCEDURE
IS
    record_variable pkg.my_record;
    return_value_from_function NUMBER(4);
BEGIN
     return_value_from_function := FUNCTION_NAME(record_variable); -- call function
END;