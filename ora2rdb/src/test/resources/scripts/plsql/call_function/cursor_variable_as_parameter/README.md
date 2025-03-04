В тестах вызывается функция FUNCTION_NAME, а также используется курсорный тип
из пакета pkg 

    CREATE OR REPLACE PACKAGE pkg AS
        TYPE cursor_type IS REF CURSOR RETURN employees%ROWTYPE;
    END pkg;
    
    
    CREATE OR REPLACE FUNCTION FUNCTION_NAME(cur_value IN OUT pkg.cursor_type)
    RETURN NUMBER
    IS
    BEGIN
        OPEN cur_value FOR SELECT * FROM employees;
    RETURN 1;
    END;

