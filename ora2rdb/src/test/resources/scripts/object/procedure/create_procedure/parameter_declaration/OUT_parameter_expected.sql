CREATE OR ALTER PROCEDURE combine_and_format_names
(
    full_name_out  VARCHAR
)
    RETURNS (full_name_out_out  VARCHAR(200))
    SQL SECURITY DEFINER
AS
BEGIN
    full_name_out = 'Ivan' || ' ' || 'Ivanov';
    full_name_out_out = full_name_out;
    suspend;
END;

-- вызов через select ... into