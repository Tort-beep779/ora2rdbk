CREATE TRIGGER TRIGGER_NAME
BEFORE INSERT ON EMPLOYEES
FOR EACH ROW
DECLARE
    value_in_function VARCHAR2(50);
    value_from_function VARCHAR2(50);
BEGIN
    value_in_function := 'value';
    value_from_function := FUNCTION_NAME(value_in_function); -- call function
END;