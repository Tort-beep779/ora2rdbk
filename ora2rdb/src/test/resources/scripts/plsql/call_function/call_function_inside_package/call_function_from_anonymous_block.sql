DECLARE
    out_value_from_function VARCHAR2(20);
    return_value_from_function VARCHAR2(20);
BEGIN
   return_value_from_function := PACKAGE_NAME.FUNCTION_NAME(out_value_from_function); -- call function
END;