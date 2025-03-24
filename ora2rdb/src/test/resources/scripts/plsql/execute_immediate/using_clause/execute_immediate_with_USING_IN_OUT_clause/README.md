### Модификаторы 
Модификаторы работают также, как и в функции/процедуре

Переменная IN передает свое значение в dynamic_sql_stmt. Переменная OUT хранит значение, которое возвращает dynamic_sql_stmt. Переменная IN OUT передает свое начальное значение в dynamic_sql_stmt и сохраняет значение, которое возвращает dynamic_sql_stmt. По умолчанию: IN.

### Предложение по конвертации
Вызов в ORACLE 

    STMT := 'BEGIN OUT_P(:a); END;';
    execute immediate STMT using in out VALUE_OUT;

Вызов в РБД 

	STMT = 'select VALUE_OUT from OUT_P(:a)';
	EXECUTE STATEMENT (:STMT) (a := VALUE_OUT) INTO :VALUE_OUT ;

Используется **INTO** 

Также стоит обратить внимание на конвенртацию 
**stmt**


### Вызываемая процедура 

Во всех тестах вызывается процедура 

ORACLE 

    CREATE OR REPLACE PROCEDURE OUT_P (VALUE_IN IN OUT NUMBER)
    AUTHID DEFINER AS
    BEGIN
    VALUE_IN := VALUE_IN + 1;
    END;

РБД 

    CREATE OR ALTER PROCEDURE OUT_P (VALUE_IN NUMERIC(34, 8))
    RETURNS( VALUE_OUT NUMERIC(34, 8))
    SQL SECURITY DEFINER
    AS
    BEGIN
        VALUE_IN = :VALUE_IN + 1;
    
        VALUE_OUT = VALUE_IN;
        SUSPEND;
    END;


### Ожидаемый результат для теста [execute_immediate_with_USING_IN_OUT_clause_inside_anonymous_block.sql](execute_immediate_with_USING_IN_OUT_clause_inside_anonymous_block.sql)
    
    -- вызовы
    EXECUTE BLOCK
    AS
        DECLARE VALUE_OUT NUMERIC(34, 8);
        DECLARE STMT VARCHAR(150);
    BEGIN
        VALUE_OUT = 0;
        STMT = 'select VALUE_OUT from OUT_P(:a)';
        EXECUTE STATEMENT (:STMT) (a := VALUE_OUT) INTO :VALUE_OUT ;
    END;

### Ожидаемый результат для теста [execute_immediate_with_USING_IN_OUT_clause_inside_function.sql](execute_immediate_with_USING_IN_OUT_clause_inside_function.sql)

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

### Ожидаемый результат для теста [execute_immediate_with_USING_IN_OUT_clause_inside_package.sql](execute_immediate_with_USING_IN_OUT_clause_inside_package.sql)

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

### Ожидаемый результат для теста [execute_immediate_with_USING_IN_OUT_clause_inside_procedure.sql](execute_immediate_with_USING_IN_OUT_clause_inside_procedure.sql)

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

### Ожидаемый результат для теста [execute_immediate_with_USING_IN_OUT_clause_inside_trigger.sql](execute_immediate_with_USING_IN_OUT_clause_inside_trigger.sql)


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