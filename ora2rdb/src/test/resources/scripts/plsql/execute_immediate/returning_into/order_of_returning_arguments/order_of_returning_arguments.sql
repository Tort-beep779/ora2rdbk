DECLARE
    sql_stmt           VARCHAR2(200);
    country_in         VARCHAR2(50) := 'Russia';
    currency_in        VARCHAR2(20) := 'Ru';
BEGIN
    sql_stmt := 'INSERT INTO COUNTRY VALUES(:1, :2)';

    EXECUTE IMMEDIATE sql_stmt
        USING country_in, currency_in;
END;