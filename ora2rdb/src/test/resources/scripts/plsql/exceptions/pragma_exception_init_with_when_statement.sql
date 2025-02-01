CREATE PROCEDURE my_procedure
IS
    invalid_month EXCEPTION;
    PRAGMA EXCEPTION_INIT (invalid_month, -1843);
BEGIN
    NULL;
    EXCEPTION
        WHEN invalid_month THEN
        NULL;
END;