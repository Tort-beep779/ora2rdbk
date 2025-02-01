CREATE OR REPLACE PROCEDURE LOC_VAR IS
    user_exception exception;
BEGIN
    IF TRUE THEN
        RAISE NO_DATA_FOUND;
    END IF;
EXCEPTION
    WHEN user_exception OR cursor_already_open THEN
        NULL;
END;