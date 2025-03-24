CREATE FUNCTION simple_case_function
RETURNS VARCHAR(32765)
SQL SECURITY DEFINER
AS
    DECLARE data_val NUMERIC(34, 8) = 35;
    DECLARE status VARCHAR(20);
BEGIN
    status =
		CASE
			WHEN :data_val = 10 OR :data_val = 20 OR :data_val = 30 OR :data_val = 40 OR :data_val = 50 THEN 'outlier'
		END;
    RETURN status;
END;