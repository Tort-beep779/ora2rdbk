CREATE EXCEPTION past_due 'past_due exception';

CREATE FUNCTION test_f
    RETURNS BOOLEAN
    SQL SECURITY DEFINER
AS
    /*past_due  EXCEPTION;*/
    /*PRAGMA EXCEPTION_INIT (past_due, -20000);*/
BEGIN
    EXCEPTION past_due( 'Account past due.');
RETURN TRUE;
END;