CREATE PROCEDURE CALLING_PROCEDURE
SQL SECURITY DEFINER
AS
     DECLARE record_variable pkg.my_record;
     DECLARE return_value_from_function NUMERIC(4);
BEGIN
    return_value_from_function = FUNCTION_NAME(:record_variable);   -- call function
END;