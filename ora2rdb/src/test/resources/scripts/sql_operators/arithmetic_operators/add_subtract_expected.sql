EXECUTE BLOCK
    AS
    DECLARE a NUMERIC(34, 8);
    DECLARE b NUMERIC(34, 8);
BEGIN
	a = 5;
    b = 4;
    a = :a - :b;
    a = :a + :b;
END;