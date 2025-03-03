CREATE EXCEPTION invalid_company_id 'invalid_company_id exception';

CREATE PROCEDURE calc_annual_sales
    SQL SECURITY DEFINER
AS
    /*past_due  EXCEPTION;*/
    /*PRAGMA EXCEPTION_INIT (past_due, -20000);*/
BEGIN
    EXCEPTION past_due( 'Account past due.');
END;