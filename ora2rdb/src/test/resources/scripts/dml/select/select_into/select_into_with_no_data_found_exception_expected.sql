CREATE EXCEPTION NO_DATA_FOUND
	'no data found';
CREATE EXCEPTION TOO_MANY_ROWS
    'too many rows';

CREATE OR ALTER PROCEDURE "PROCEDURE_1"
as
     DECLARE v_employee_name VARCHAR(100);
     DECLARE v_employee_salary NUMERIC(34, 8);
begin
     SELECT employee_name, salary
     FROM employees
     INTO :v_employee_name, :v_employee_salary;
     IF (ROW_COUNT = 0) THEN
     	EXCEPTION NO_DATA_FOUND;
    IF (ROW_COUNT > 1) THEN   -- уточнить про обработку подобного исключения
     	EXCEPTION TOO_MANY_ROWS;
end /*PROCEDURE_1*/;