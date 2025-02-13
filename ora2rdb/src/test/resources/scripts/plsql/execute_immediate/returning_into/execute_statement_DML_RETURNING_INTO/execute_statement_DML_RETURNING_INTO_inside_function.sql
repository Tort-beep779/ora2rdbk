CREATE FUNCTION test_f
    RETURN BOOLEAN
IS
    sql_stmt           VARCHAR2(200);
    country_in         VARCHAR2(50) := 'Russia';
    currency_in        VARCHAR2(20) := 'Ru';
    returning_currency  VARCHAR2(50);
    returning_country VARCHAR2(50);
BEGIN
    sql_stmt := 'INSERT INTO COUNTRY VALUES(:1, :2) RETURNING COUNTRY INTO :3';

    EXECUTE IMMEDIATE sql_stmt
        USING country_in, currency_in
                RETURNING INTO returning_country;

    sql_stmt := NULL;
        sql_stmt := 'UPDATE COUNTRY SET CURRENCY = :1 WHERE COUNTRY = :2 RETURNING COUNTRY INTO :returning_country';

    EXECUTE IMMEDIATE sql_stmt
        USING currency_in, country_in
            RETURNING INTO returning_country;

    sql_stmt := NULL;
        sql_stmt := 'DELETE FROM COUNTRY WHERE country = :1 returning currency into :2';

    EXECUTE IMMEDIATE sql_stmt
        USING country_in
        RETURNING INTO returning_currency;
END;