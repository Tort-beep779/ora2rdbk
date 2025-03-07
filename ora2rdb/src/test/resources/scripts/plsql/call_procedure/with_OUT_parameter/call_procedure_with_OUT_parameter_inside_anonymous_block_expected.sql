EXECUTE BLOCK
    AS
    DECLARE out_value VARCHAR(50);
BEGIN
	out_value = 'out_value';
    SELECT OUT_PARAMETER_OUT FROM PROCEDURE_NAME(:out_value) INTO :out_value;
END;