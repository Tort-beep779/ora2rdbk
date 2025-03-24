EXECUTE BLOCK
AS
     DECLARE record_variable pkg.my_record;
     DECLARE out_value NUMERIC(4);
BEGIN
	out_value = FUNCTION_NAME(:record_variable);   -- call function
END;