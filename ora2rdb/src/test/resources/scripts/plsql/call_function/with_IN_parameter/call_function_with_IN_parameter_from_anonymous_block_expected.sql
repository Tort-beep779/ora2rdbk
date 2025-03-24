EXECUTE BLOCK
AS
	DECLARE value_in_function VARCHAR(50);
	DECLARE value_from_function VARCHAR(50);
BEGIN
	value_in_function = 'value';
	value_from_function = FUNCTION_NAME(:value_in_function); -- call function
END;