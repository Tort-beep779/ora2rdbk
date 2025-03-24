CREATE PROCEDURE calc_annual_sales
    IS
        past_due  EXCEPTION;
        PRAGMA EXCEPTION_INIT (past_due, -20000);
BEGIN
    RAISE_APPLICATION_ERROR(-20000, 'Account past due.');
END;