CREATE OR REPLACE PROCEDURE LOC_VAR IS
    user_exception exception;
    user_exception_2 exception;
BEGIN
    IF TRUE THEN
        RAISE user_exception_2;
    END IF;
EXCEPTION
    WHEN user_exception OR user_exception_2 THEN
        NULL;
END;