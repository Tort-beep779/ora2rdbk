DECLARE
    past_due  EXCEPTION;                       -- declare exception
    PRAGMA EXCEPTION_INIT (past_due, -20000);  -- assign error code to exception
BEGIN
    RAISE_APPLICATION_ERROR(-20000, 'Account past due.');
END;