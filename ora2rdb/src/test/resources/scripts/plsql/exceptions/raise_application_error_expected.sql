CREATE EXCEPTION past_due 'past_due exception';

EXECUTE BLOCK
    AS
    /*past_due  EXCEPTION;*/                      -- declare exception
    /*PRAGMA EXCEPTION_INIT (past_due, -20000);*/ -- assign error code to exception
BEGIN
    EXCEPTION past_due( 'Account past due.');
/*EXCEPTION*/
    WHEN PAST_DUE DO                         -- handle exception
    BEGIN

    END
END;