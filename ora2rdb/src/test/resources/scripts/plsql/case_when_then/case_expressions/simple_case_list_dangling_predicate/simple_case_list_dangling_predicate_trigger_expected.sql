CREATE OR ALTER TRIGGER simple_case_trigger
BEFORE INSERT ON employees
SQL SECURITY DEFINER
AS
    DECLARE data_val NUMERIC(34, 8) = 35;
    DECLARE status VARCHAR(20);
BEGIN
    status =
		CASE
			WHEN :data_val < 0 OR :data_val > 50 THEN 'outlier'
			WHEN :data_val < 20 OR :data_val > 30 THEN 'text'
		END;
 END;
