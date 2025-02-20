CREATE FUNCTION function_name
    RETURN BOOLEAN
    AS
    CURSOR cur IS
        SELECT * FROM employees;
    cur_rec cur%ROWTYPE;
BEGIN
    NULL;
END;