EXECUTE BLOCK
    AS
BEGIN
    EXECUTE STATEMENT ('CREATE INDEX emp_u_1 ON employees (last_name)');
END;