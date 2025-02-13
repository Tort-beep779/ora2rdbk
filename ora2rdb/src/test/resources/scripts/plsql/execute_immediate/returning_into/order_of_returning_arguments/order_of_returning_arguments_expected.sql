EXECUTE BLOCK
    AS
    DECLARE sql_stmt           VARCHAR(200);
     DECLARE country_in         VARCHAR(50) = 'Russia';
     DECLARE currency_in        VARCHAR(20) = 'Ru';

BEGIN
	sql_stmt = 'INSERT INTO COUNTRY VALUES(:value1, :value2)';

    EXECUTE STATEMENT (:sql_stmt)
        (value1 := country_in , value2 := currency_in);
END;