CREATE EXCEPTION past_due 'past_due exception';

CREATE OR ALTER PACKAGE errnums
AS BEGIN
    PROCEDURE PP_Grade_meaning1;
END;

RECREATE PACKAGE BODY errnums
AS BEGIN
    /*past_due  EXCEPTION;*/
    /*PRAGMA EXCEPTION_INIT (past_due, -20000);*/
    PROCEDURE PP_Grade_meaning1
        AS
    BEGIN
        EXCEPTION past_due( 'Account past due.');
    END
END;