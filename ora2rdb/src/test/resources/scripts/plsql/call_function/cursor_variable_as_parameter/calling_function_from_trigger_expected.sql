/*CREATE TRIGGER TRIGGER_NAME
BEFORE INSERT ON EMPLOYEES
SQL SECURITY DEFINER
AS
     [-unconvertible DECLARE cursor_variable pkg.cursor_type];
     DECLARE return_value_from_function NUMERIC(34, 8);
 BEGIN
     return_value_from_function = FUNCTION_NAME([-unconvertible :cursor_variable]); -- call function
 END;*/