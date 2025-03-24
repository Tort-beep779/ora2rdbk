CREATE PROCEDURE CALLING_PROCEDURE
    SQL SECURITY DEFINER
AS
    DECLARE record_variable pkg.my_record;
BEGIN
    EXECUTE PROCEDURE PROCEDURE_NAME(:record_variable);   -- call procedure
END;
