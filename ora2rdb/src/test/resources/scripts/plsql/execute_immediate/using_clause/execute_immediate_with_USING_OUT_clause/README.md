В тестах вызывается процедура 

ORACLE

    CREATE OR REPLACE PROCEDURE OUT_P (VALUE_IN OUT NUMBER)
    AUTHID DEFINER AS
    BEGIN
        VALUE_IN := 1;
    END;

РБД 

    CREATE OR ALTER PROCEDURE OUT_P (VALUE_IN  NUMERIC(34, 8))
    RETURNS( VALUE_IN_OUT NUMERIC(34, 8))
    SQL SECURITY DEFINER
    AS
    BEGIN
        VALUE_IN = 1;
    
        VALUE_IN_OUT = VALUE_IN;
        SUSPEND;
    END;


### Ожидаемый результат для теста [execute_immediate_with_USING_OUT_clause_inside_anonymous_block.sql](execute_immediate_with_USING_OUT_clause_inside_anonymous_block.sql)
    EXECUTE BLOCK
    AS
        DECLARE VALUE_OUT NUMERIC(34, 8);
        DECLARE STMT VARCHAR(150);
    BEGIN
        VALUE_OUT = 0;
        STMT = 'select VALUE_OUT from OUT_P(:a)';
        EXECUTE STATEMENT (:STMT) (a := VALUE_OUT) ;
    END;
### Ожидаемый результат для теста [execute_immediate_with_USING_OUT_clause_inside_function.sql](execute_immediate_with_USING_OUT_clause_inside_function.sql)
    CREATE OR ALTER FUNCTION CALL_F
    RETURNS BOOLEAN
    SQL SECURITY DEFINER
    AS
        DECLARE VALUE_OUT NUMERIC(34, 8);
        DECLARE STMT VARCHAR(50);
    BEGIN
        VALUE_OUT = 0;
        STMT = 'select VALUE_OUT from OUT_P(:a)';
        EXECUTE STATEMENT (:STMT) (a := VALUE_OUT) INTO :VALUE_OUT ;
        RETURN TRUE;
    END;

### Ожидаемый результат для теста [execute_immediate_with_USING_OUT_clause_inside_package.sql](execute_immediate_with_USING_OUT_clause_inside_package.sql)
    CREATE OR ALTER PACKAGE call_pckg
    AS BEGIN
        PROCEDURE test_p;
        FUNCTION test_f RETURNS BOOLEAN;
    END;

    RECREATE PACKAGE BODY call_pckg
    AS
    BEGIN
    FUNCTION test_f
    RETURNS BOOLEAN
    AS
        DECLARE VALUE_OUT NUMERIC(34, 8);
        DECLARE STMT VARCHAR(50);
    BEGIN
        VALUE_OUT = 0;
        STMT = 'select VALUE_OUT from OUT_P(:a)';
        EXECUTE STATEMENT (:STMT) (a := VALUE_OUT) INTO :VALUE_OUT ;
        RETURN TRUE;
    END
    PROCEDURE test_p
    AS
        DECLARE VALUE_OUT NUMERIC(34, 8);
        DECLARE STMT VARCHAR(50);
    BEGIN
        VALUE_OUT = 0;
        STMT = 'select VALUE_OUT from OUT_P(:a)';
        EXECUTE STATEMENT (:STMT) (a := VALUE_OUT) INTO :VALUE_OUT ;
    END
    END;

### Ожидаемый результат для теста [execute_immediate_with_USING_OUT_clause_inside_procedure.sql](execute_immediate_with_USING_OUT_clause_inside_procedure.sql)

    CREATE OR ALTER PROCEDURE call_p
	SQL SECURITY DEFINER
    AS
        DECLARE VALUE_OUT NUMERIC(34, 8);
        DECLARE STMT VARCHAR(50);
    BEGIN
        VALUE_OUT = 0;
        STMT = 'select VALUE_OUT from OUT_P(:a)';
        EXECUTE STATEMENT (:STMT) (a := VALUE_OUT) INTO :VALUE_OUT ;
    
    END;

### Ожидаемый результат для теста [execute_immediate_with_USING_OUT_clause_inside_trigger.sql](execute_immediate_with_USING_OUT_clause_inside_trigger.sql)


    CREATE OR ALTER TRIGGER call_tr
    AFTER INSERT
    ON country
    SQL SECURITY DEFINER
    AS
        DECLARE VALUE_OUT NUMERIC(34, 8);
        DECLARE STMT VARCHAR(50);
    BEGIN
        VALUE_OUT = 0;
        STMT = 'select VALUE_OUT from OUT_P(:a)';
        EXECUTE STATEMENT (:STMT) (a := VALUE_OUT) INTO :VALUE_OUT ;
    END;