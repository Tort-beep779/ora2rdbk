CREATE PROCEDURE calc_annual_sales
    IS
    CURSOR cur IS
        SELECT * FROM employees;
    cur_rec cur%ROWTYPE;
BEGIN
    NULL;
END;