CREATE TRIGGER T_Grade_meaning1
    AFTER INSERT
    ON EMPLOYEES
    FOR EACH ROW
DECLARE
    CURSOR cur IS
        SELECT * FROM employees;
    cur_rec cur%ROWTYPE;
BEGIN
    NULL;
END;