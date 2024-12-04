CREATE PROCEDURE combine_and_format_names
(
full_name_out IN VARCHAR2
)
IS
BEGIN
    IF full_name_out = 'John'
THEN
    DBMS_OUTPUT.PUT_LINE('correct');
END IF;
END;