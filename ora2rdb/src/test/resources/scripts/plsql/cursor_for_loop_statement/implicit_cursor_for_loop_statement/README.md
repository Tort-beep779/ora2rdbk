### Предложение по конвертации

Объявить переменные, по которым делается выборка .В эти переменные считывать данные.

### Ожидаемый результат для теста [implicit_cursor_for_loop_statement_inside_anonymous_block.sql](implicit_cursor_for_loop_statement_inside_anonymous_block.sql)

    EXECUTE BLOCK
    AS
        DECLARE VARIABLE LAST_NAME TYPE OF COLUMN EMPLOYEE.LAST_NAME;
        DECLARE VARIABLE JOB_ID TYPE OF COLUMN EMPLOYEE.EMP_NO;
    BEGIN
        FOR SELECT LAST_NAME, EMP_NO
            FROM EMPLOYEE
            INTO :LAST_NAME, :JOB_ID
        DO
        BEGIN
        
        END
    END;


### Ожидаемый результат для теста [implicit_cursor_for_loop_statement_inside_function.sql](implicit_cursor_for_loop_statement_inside_function.sql)
    CREATE FUNCTION F_Grade_meaning1
    RETURNS BOOLEAN
    AS
        DECLARE VARIABLE LAST_NAME TYPE OF COLUMN EMPLOYEE.LAST_NAME;
        DECLARE VARIABLE JOB_ID TYPE OF COLUMN EMPLOYEE.EMP_NO;
    BEGIN
        FOR SELECT LAST_NAME, EMP_NO
            FROM EMPLOYEE
            INTO :LAST_NAME, :JOB_ID
        DO
        BEGIN
        
        END
    RETURN TRUE;
    END; 



### Ожидамеый результат для теста [implicit_cursor_for_loop_statement_inside_procedure.sql](implicit_cursor_for_loop_statement_inside_procedure.sql)
    CREATE PROCEDURE P_Grade_meaning1
    AS
        DECLARE VARIABLE LAST_NAME TYPE OF COLUMN EMPLOYEE.LAST_NAME;
        DECLARE VARIABLE JOB_ID TYPE OF COLUMN EMPLOYEE.EMP_NO;
    BEGIN
        FOR SELECT LAST_NAME, EMP_NO
            FROM EMPLOYEE
            INTO :LAST_NAME, :JOB_ID
        DO
        BEGIN
    
        END
    END; 

### Ожидаемый результат для теста [implicit_cursor_for_loop_statement_inside_trigger.sql](implicit_cursor_for_loop_statement_inside_trigger.sql)

    CREATE OR ALTER TRIGGER T_Grade_meaning1
    AFTER INSERT
    ON EMPLOYEE
    AS
        DECLARE VARIABLE LAST_NAME TYPE OF COLUMN EMPLOYEE.LAST_NAME;
        DECLARE VARIABLE JOB_ID TYPE OF COLUMN EMPLOYEE.EMP_NO;
    BEGIN
        FOR SELECT LAST_NAME, EMP_NO
            FROM EMPLOYEE
            INTO :LAST_NAME, :JOB_ID
        DO
        BEGIN
        
        END
    END /*T_Grade_meaning1*/;


### Ожидаемый результат для теста [implicit_cursor_for_loop_statement_inside_package.sql](implicit_cursor_for_loop_statement_inside_package.sql)

    CREATE OR ALTER PACKAGE Pack_Grade_meaning1
    AS
    BEGIN
        FUNCTION PF_Grade_meaning1 (degree INTEGER)
        RETURNS BOOLEAN ;  
        PROCEDURE PP_Grade_meaning1;
    END /*Pack_Grade_meaning1*/;


    RECREATE PACKAGE BODY Pack_Grade_meaning1
    AS
    BEGIN
        FUNCTION PF_Grade_meaning1 (degree INTEGER)
        RETURNS BOOLEAN
        AS
        DECLARE VARIABLE LAST_NAME TYPE OF COLUMN EMPLOYEE.LAST_NAME;
        DECLARE VARIABLE JOB_ID TYPE OF COLUMN EMPLOYEE.EMP_NO;
        BEGIN
        FOR SELECT LAST_NAME, EMP_NO
        FROM EMPLOYEE
        INTO :LAST_NAME, :JOB_ID
        DO
        BEGIN
        
                END
            RETURN TRUE;
        END
    
        PROCEDURE PP_Grade_meaning1
        AS
            DECLARE VARIABLE LAST_NAME TYPE OF COLUMN EMPLOYEE.LAST_NAME;
            DECLARE VARIABLE JOB_ID TYPE OF COLUMN EMPLOYEE.EMP_NO;
        BEGIN
            FOR SELECT LAST_NAME, EMP_NO
                FROM EMPLOYEE
                INTO :LAST_NAME, :JOB_ID
            DO
            BEGIN
    
            END
        END  
    END /*Pack_Grade_meaning1*/;