### Предложение по конвертированию 

В ORACLE

    sql_stmt := 'DELETE FROM COUNTRY WHERE country = :1 returning currency into :2';
    
    EXECUTE IMMEDIATE sql_stmt
    USING country_in
    RETURNING INTO returning_currency;

В РБД 

    sql_stmt = 'DELETE FROM COUNTRY WHERE country = :country_in RETURNING currency';

    EXECUTE STATEMENT (:sql_stmt)
    (country_in := country_in)
    INTO :returning_currency;


Удаляем запись 

    into :2

Вместо **RETURNING INTO returning_currency;** пишем **INTO :returning_currency;**

**Аналогично c INSERT / UPDATE**

------------------------

### Ожидаемый результат для теста [execute_statement_DML_RETURNING_INTO_inside_anonymous_block.sql](execute_statement_DML_RETURNING_INTO_inside_anonymous_block.sql)

    EXECUTE BLOCK
    AS
        DECLARE sql_stmt           VARCHAR(200);
	    DECLARE country_in         VARCHAR(50) = 'Russia';
	    DECLARE currency_in        VARCHAR(20) = 'Ru';
	    DECLARE returning_country  VARCHAR(50);
	    DECLARE returning_currency VARCHAR(50);
    BEGIN

    sql_stmt = 'INSERT INTO COUNTRY VALUES(:country_in, :currency_in) RETURNING COUNTRY';
    
        EXECUTE STATEMENT (:sql_stmt)
        (country_in := country_in, currency_in := currency_in)
            INTO :returning_country;
            
 	sql_stmt = NULL;     
 	
 	sql_stmt = 'UPDATE COUNTRY SET CURRENCY = :currency_in WHERE COUNTRY = :country_in RETURNING COUNTRY';
	    
	    EXECUTE STATEMENT (:sql_stmt)
	    (currency_in := currency_in, country_in := country_in)
	    INTO :returning_country;
    
    sql_stmt = NULL;  
    
    sql_stmt = 'DELETE FROM COUNTRY WHERE country = :country_in RETURNING currency';
    
    EXECUTE STATEMENT (:sql_stmt)
        (country_in := country_in)
        INTO :returning_currency;

    END;

------------------------
### Ожидаемый результат для теста [execute_statement_DML_RETURNING_INTO_inside_function.sql](execute_statement_DML_RETURNING_INTO_inside_function.sql)


    CREATE FUNCTION test_f
    RETURNS BOOLEAN
    SQL SECURITY DEFINER
    AS
    DECLARE sql_stmt           VARCHAR(200);
    DECLARE country_in         VARCHAR(50) = 'Russia';
    DECLARE currency_in        VARCHAR(20) = 'Ru';
    DECLARE returning_country  VARCHAR(50);
    DECLARE returning_currency VARCHAR(50);
    BEGIN

    sql_stmt = 'INSERT INTO COUNTRY VALUES(:country_in, :currency_in) RETURNING COUNTRY';

    EXECUTE STATEMENT (:sql_stmt)
        (country_in := country_in, currency_in := currency_in)
                INTO :returning_country;

    sql_stmt = NULL;
 	sql_stmt = 'UPDATE COUNTRY SET CURRENCY = :currency_in WHERE COUNTRY = :country_in RETURNING COUNTRY';

    EXECUTE STATEMENT (:sql_stmt)
        (currency_in := currency_in, country_in := country_in)
            INTO :returning_country;

    sql_stmt = NULL;
    sql_stmt = 'DELETE FROM COUNTRY WHERE country = :country_in RETURNING currency';

    EXECUTE STATEMENT (:sql_stmt)
        (country_in := country_in)
            INTO :returning_currency;

    END;
------------------------

### Ожидаемый результат для теста [execute_statement_DML_RETURNING_INTO_inside_package.sql](execute_statement_DML_RETURNING_INTO_inside_package.sql)

    CREATE OR ALTER PACKAGE test_pckg
    AS BEGIN
    PROCEDURE test_p;
    FUNCTION test_f RETURNS BOOLEAN;
    END;
    
    RECREATE PACKAGE BODY test_pckg
    AS
    BEGIN
    FUNCTION test_f
    RETURNS BOOLEAN
    AS
    DECLARE sql_stmt           VARCHAR(200);
    DECLARE country_in         VARCHAR(50) = 'Russia';
    DECLARE returning_currency  VARCHAR(50);
    BEGIN
    sql_stmt = 'INSERT INTO COUNTRY VALUES(:country_in, :currency_in) RETURNING COUNTRY';

        EXECUTE STATEMENT (:sql_stmt)
            (country_in := country_in, currency_in := currency_in)
                                INTO :returning_country;

        sql_stmt = NULL;

        sql_stmt = 'UPDATE COUNTRY SET CURRENCY = :currency_in WHERE COUNTRY = :country_in RETURNING COUNTRY';

        EXECUTE STATEMENT (:sql_stmt)
            (currency_in := currency_in, country_in := country_in)
                            INTO :returning_country;

        sql_stmt = NULL;

        sql_stmt = 'DELETE FROM COUNTRY WHERE country = :country_in RETURNING currency';

        EXECUTE STATEMENT (:sql_stmt)
            (country_in := country_in)
                            INTO :returning_currency;
    END

	PROCEDURE test_p
    AS
        DECLARE sql_stmt           VARCHAR(200);
        DECLARE country_in         VARCHAR(50) = 'Russia';
        DECLARE returning_currency  VARCHAR(50);
    BEGIN
        sql_stmt = 'INSERT INTO COUNTRY VALUES(:country_in, :currency_in) RETURNING COUNTRY';

        EXECUTE STATEMENT (:sql_stmt)
            (country_in := country_in, currency_in := currency_in)
                                INTO :returning_country;

        sql_stmt = NULL;

        sql_stmt = 'UPDATE COUNTRY SET CURRENCY = :currency_in WHERE COUNTRY = :country_in RETURNING COUNTRY';

        EXECUTE STATEMENT (:sql_stmt)
            (currency_in := currency_in, country_in := country_in)
                            INTO :returning_country;

        sql_stmt = NULL;

        sql_stmt = 'DELETE FROM COUNTRY WHERE country = :country_in RETURNING currency';

        EXECUTE STATEMENT (:sql_stmt)
            (country_in := country_in)
                            INTO :returning_currency;
    END
    END;

------------------------


### Ожидаемый результат для теста [execute_statement_DML_RETURNING_INTO_inside_procedure.sql](execute_statement_DML_RETURNING_INTO_inside_procedure.sql)

    CREATE PROCEDURE test_p
    SQL SECURITY DEFINER
    AS
        DECLARE sql_stmt           VARCHAR(200);
        DECLARE country_in         VARCHAR(50) = 'Russia';
        DECLARE currency_in        VARCHAR(20) = 'Ru';
        DECLARE returning_country  VARCHAR(50);
        DECLARE returning_currency VARCHAR(50);
    BEGIN

    sql_stmt = 'INSERT INTO COUNTRY VALUES(:country_in, :currency_in) RETURNING COUNTRY';

    EXECUTE STATEMENT (:sql_stmt)
        (country_in := country_in, currency_in := currency_in)
                    INTO :returning_country;

    sql_stmt = NULL;
 	sql_stmt = 'UPDATE COUNTRY SET CURRENCY = :currency_in WHERE COUNTRY = :country_in RETURNING COUNTRY';

    EXECUTE STATEMENT (:sql_stmt)
        (currency_in := currency_in, country_in := country_in)
                INTO :returning_country;

    sql_stmt = NULL;
    sql_stmt = 'DELETE FROM COUNTRY WHERE country = :country_in RETURNING currency';

    EXECUTE STATEMENT (:sql_stmt)
        (country_in := country_in)
                INTO :returning_currency;
    END;


------------------------


### Ожидаемый результат для теста [execute_statement_DML_RETURNING_INTO_inside_trigger.sql](execute_statement_DML_RETURNING_INTO_inside_trigger.sql)

    CREATE OR ALTER TRIGGER test_tr
    AFTER INSERT
    ON country
    SQL SECURITY DEFINER
    AS
        DECLARE sql_stmt           VARCHAR(200);
        DECLARE country_in         VARCHAR(50) = 'Russia';
        DECLARE currency_in        VARCHAR(20) = 'Ru';
        DECLARE returning_country  VARCHAR(50);
        DECLARE returning_currency VARCHAR(50);
    BEGIN

    sql_stmt = 'INSERT INTO COUNTRY VALUES(:country_in, :currency_in) RETURNING COUNTRY';

    EXECUTE STATEMENT (:sql_stmt)
        (country_in := country_in, currency_in := currency_in)
                    INTO :returning_country;

    sql_stmt = NULL;
 	sql_stmt = 'UPDATE COUNTRY SET CURRENCY = :currency_in WHERE COUNTRY = :country_in RETURNING COUNTRY';

    EXECUTE STATEMENT (:sql_stmt)
        (currency_in := currency_in, country_in := country_in)
                INTO :returning_country;

    sql_stmt = NULL;
    sql_stmt = 'DELETE FROM COUNTRY WHERE country = :country_in RETURNING currency';

    EXECUTE STATEMENT (:sql_stmt)
        (country_in := country_in)
                INTO :returning_currency;
    END;


