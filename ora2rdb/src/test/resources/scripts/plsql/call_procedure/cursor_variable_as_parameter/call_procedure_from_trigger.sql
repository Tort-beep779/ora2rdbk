CREATE TRIGGER TRIGGER_NAME
BEFORE INSERT ON EMPLOYEES
FOR EACH ROW
DECLARE
    cursor_variable pkg.cursor_type;
BEGIN
     PROCEDURE_NAME(cursor_variable); -- call procedure
END;