CREATE PROCEDURE combine_and_format_names
(
    full_name_out OUT VARCHAR2
)
    IS
BEGIN
    full_name_out := 'Ivan' || ' ' || 'Ivanov';
END;