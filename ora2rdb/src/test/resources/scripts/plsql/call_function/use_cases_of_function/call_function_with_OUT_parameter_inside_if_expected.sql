CREATE FUNCTION CALLING_F
RETURNS VARCHAR(32765)
AS
     DECLARE out_value_from_function VARCHAR(50);
     DECLARE return_value_from_function VARCHAR(50);
BEGIN
	SELECT RET_VAL, OUT_VALUE_OUT FROM FUNCTION_NAME(:out_value_from_function, 'in_value') INTO return_value_from_function, out_value_from_function;
    if (return_value_from_function = 'in_value') then   -- inside IF-ELSE
        RETURN out_value_from_function;
    RETURN 'empty';
END;