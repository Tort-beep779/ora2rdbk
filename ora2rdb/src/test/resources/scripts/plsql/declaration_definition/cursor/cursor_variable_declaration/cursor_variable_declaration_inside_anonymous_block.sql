DECLARE
    CURSOR cur IS
        SELECT * FROM employees;
    cur_rec cur%ROWTYPE;
BEGIN
    NULL;
END;