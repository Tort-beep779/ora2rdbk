В тестах используются 

    CREATE OR REPLACE PACKAGE pkg AS
        TYPE cursor_type IS REF CURSOR RETURN employees%ROWTYPE;
    END pkg;


    CREATE OR REPLACE PROCEDURE PROCEDURE_NAME
        (cur_value IN OUT pkg.cursor_type)
    IS
    BEGIN
        OPEN cur_value FOR SELECT * FROM employees;
    END;