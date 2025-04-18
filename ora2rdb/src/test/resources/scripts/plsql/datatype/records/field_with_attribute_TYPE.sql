DECLARE
    TYPE type_rec IS RECORD (
        first_name employees.first_name%TYPE,
        last_name employees.last_name%TYPE,
        rating NUMBER);

    v_rec type_rec;
BEGIN
    NULL;
END;