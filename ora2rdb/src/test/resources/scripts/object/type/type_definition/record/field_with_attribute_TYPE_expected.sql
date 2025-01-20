EXECUTE BLOCK
    AS
    DECLARE TYPE type_rec (
        first_name TYPE OF COLUMN employees.first_name,
        last_name TYPE OF COLUMN employees.last_name,
        rating NUMERIC(34, 8));

    DECLARE v_rec type_rec;
BEGIN

END;