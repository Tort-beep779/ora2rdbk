CREATE TRIGGER TRIGGER_NAME
BEFORE INSERT ON EMPLOYEE
SQL SECURITY DEFINER
AS
	DECLARE out_value_from_function VARCHAR(50);
     DECLARE return_value_from_function VARCHAR(50);
BEGIN
    SELECT RET_VAL, OUT_VALUE_OUT FROM PACKAGE_NAME.FUNCTION_NAME(:out_value_from_function) INTO return_value_from_function, out_value_from_function; -- call function
END;