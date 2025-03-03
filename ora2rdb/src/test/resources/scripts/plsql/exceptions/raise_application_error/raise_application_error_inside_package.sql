CREATE OR REPLACE PACKAGE errnums
IS
    past_due  EXCEPTION;
    PRAGMA EXCEPTION_INIT (past_due, -20000);
    PROCEDURE PP_Grade_meaning1;
END;

CREATE OR REPLACE PACKAGE BODY errnums
IS
    PROCEDURE PP_Grade_meaning1
        IS
    BEGIN
        RAISE_APPLICATION_ERROR(-20000, 'Account past due.');
    END;
END;