CREATE FUNCTION CALLING_FUNCTION
RETURN NUMBER
    IS
    record_variable pkg.my_record;
BEGIN
     PROCEDURE_NAME(record_variable);   -- call procedure
END;