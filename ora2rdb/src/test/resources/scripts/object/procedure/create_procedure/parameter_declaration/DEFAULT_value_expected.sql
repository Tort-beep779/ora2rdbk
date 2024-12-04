CREATE OR ALTER PROCEDURE pr
    (
    first_name_in VARCHAR DEFAULT 'IVAN'
    )
    SQL SECURITY DEFINER
    AS
BEGIN
	RDB$TRACE_MSG(first_name_in, false);
END;