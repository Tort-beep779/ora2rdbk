CREATE EXCEPTION invalid_company_id 'invalid_company_id exception';

CREATE TRIGGER T_Grade_meaning1
    AFTER INSERT
    ON EMPLOYEES
    SQL SECURITY DEFINER
AS
    /*past_due  EXCEPTION;*/
    /*PRAGMA EXCEPTION_INIT (past_due, -20000);*/
BEGIN
    EXCEPTION past_due( 'Account past due.');
END;