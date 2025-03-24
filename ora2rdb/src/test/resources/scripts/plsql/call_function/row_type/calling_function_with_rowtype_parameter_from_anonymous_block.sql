DECLARE
    record_variable pkg.my_record;
    out_value NUMBER(4);
BEGIN
    out_value := FUNCTION_NAME(record_variable);   -- call function
END;