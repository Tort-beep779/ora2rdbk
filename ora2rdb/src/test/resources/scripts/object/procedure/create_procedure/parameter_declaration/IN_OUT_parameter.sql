CREATE PROCEDURE combine_and_format_names
(
full_name_out IN OUT VARCHAR2
)
IS
BEGIN
    IF full_name_out = 'John'
THEN
    full_name_out := 'Ivan' || ' ' || 'Ivanov';
END IF;
END;