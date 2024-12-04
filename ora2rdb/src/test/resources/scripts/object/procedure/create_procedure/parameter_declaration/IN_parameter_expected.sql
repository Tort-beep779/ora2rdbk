CREATE OR ALTER PROCEDURE combine_and_format_names
(
    full_name_out  VARCHAR
)
    SQL SECURITY DEFINER
    AS
BEGIN
    IF (full_name_out = 'John')
THEN
     RDB$TRACE_MSG('correct' , false);
END;

-- вызов через execute immediate

