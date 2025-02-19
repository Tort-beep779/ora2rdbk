### Предложение по конвертации 

Объявить переменные, по которым делается выборка .В эти переменные считывать данные. Тело курсора 
перенести в FOR SELECT 

----------------------------------------


### [explicit_cursor_for_loop_statement_declaration_inside_package.sql](explicit_cursor_for_loop_statement_declaration_inside_package.sql)

В этом тесте курсор объявляется внутри пакета . В РБД так сделать нельзя. 
Курсор комментируется, но выборка происходит 

**Ожидаемый результат** 

    CREATE OR ALTER PACKAGE Pack_Grade_meaning1
    AS
    BEGIN
    FUNCTION PF_Grade_meaning1 (degree INTEGER)
    RETURNS BOOLEAN ;  
    PROCEDURE PP_Grade_meaning1;

    /*CURSOR BOOKS_CUR RETURN BOOKS%ROWTYPE;*/

    /*CURSOR C1 IS
        SELECT LAST_NAME, JOB_ID FROM EMPLOYEES
        WHERE MANAGER_ID > 120
        ORDER BY LAST_NAME;*/

    END /*Pack_Grade_meaning1*/;

    RECREATE PACKAGE BODY Pack_Grade_meaning1
    AS
    BEGIN
        /*CURSOR BOOKS_CUR
        RETURN BOOKS%ROWTYPE
        IS
        SELECT BOOK_NAME
        FROM BOOKS;*/

        FUNCTION PF_Grade_meaning1 (degree INTEGER)
        RETURNS BOOLEAN
        AS
            DECLARE VARIABLE LAST_NAME TYPE OF COLUMN EMPLOYEE.LAST_NAME;
            DECLARE VARIABLE JOB_ID TYPE OF COLUMN EMPLOYEE.EMP_NO;
            BEGIN
                FOR SELECT LAST_NAME, JOB_ID FROM EMPLOYEES
                WHERE MANAGER_ID > 120
                ORDER BY LAST_NAME
                INTO :LAST_NAME, :JOB_ID
                DO BEGIN
            
                END
            RETURN TRUE;
        END
    
        PROCEDURE PP_Grade_meaning1
        AS
            DECLARE VARIABLE BOOK_NAME TYPE OF COLUMN BOOKS.BOOK_NAME;
            BEGIN
                 FOR SELECT BOOK_NAME
                    FROM BOOKS;
                    INTO :BOOK_NAME
                DO BEGIN
                    
                END
        END  
    END /*Pack_Grade_meaning1*/;

---------------------------------------
### Ожидаемый результат для теста [explicit_cursor_for_loop_statement_inside_anonymous_block.sql](explicit_cursor_for_loop_statement_inside_anonymous_block.sql)

    EXECUTE BLOCK
    AS
        DECLARE C1 CURSOR  FOR
        (SELECT LAST_NAME, JOB_ID FROM EMPLOYEES
        WHERE MANAGER_ID > 120
        ORDER BY LAST_NAME);

        DECLARE VARIABLE LAST_NAME TYPE OF COLUMN EMPLOYEE.LAST_NAME;
        DECLARE VARIABLE JOB_ID TYPE OF COLUMN EMPLOYEE.EMP_NO;
    BEGIN
        FOR SELECT LAST_NAME, JOB_ID FROM EMPLOYEES
            WHERE MANAGER_ID > 120
            ORDER BY LAST_NAME
            INTO :LAST_NAME, :JOB_ID
        DO BEGIN
            
        END
    END;

----------------------------------------
### Ожидаемый результат для теста [explicit_cursor_for_loop_statement_inside_procedure.sql](explicit_cursor_for_loop_statement_inside_procedure.sql)

    CREATE PROCEDURE P_Grade_meaning1
    AS
        DECLARE C1 CURSOR  FOR
        (SELECT LAST_NAME, JOB_ID FROM EMPLOYEES
        WHERE MANAGER_ID > 120
        ORDER BY LAST_NAME);

        DECLARE VARIABLE LAST_NAME TYPE OF COLUMN EMPLOYEE.LAST_NAME;
        DECLARE VARIABLE JOB_ID TYPE OF COLUMN EMPLOYEE.EMP_NO;
    BEGIN
         FOR SELECT LAST_NAME, JOB_ID FROM EMPLOYEES
            WHERE MANAGER_ID > 120
            ORDER BY LAST_NAME
            INTO :LAST_NAME, :JOB_ID
        DO BEGIN
            
        END
    END; 

----------------------------------------
### Ожидаемый результат для теста [explicit_cursor_for_loop_statement_inside_function.sql](explicit_cursor_for_loop_statement_inside_function.sql)

    CREATE FUNCTION F_Grade_meaning1
    RETURNS BOOLEAN
    AS
        DECLARE C1 CURSOR  FOR
        (SELECT LAST_NAME, JOB_ID FROM EMPLOYEES
        WHERE MANAGER_ID > 120
        ORDER BY LAST_NAME);

        DECLARE VARIABLE LAST_NAME TYPE OF COLUMN EMPLOYEE.LAST_NAME;
        DECLARE VARIABLE JOB_ID TYPE OF COLUMN EMPLOYEE.EMP_NO;
    BEGIN
        FOR SELECT LAST_NAME, JOB_ID FROM EMPLOYEES
        WHERE MANAGER_ID > 120
        ORDER BY LAST_NAME
        INTO :LAST_NAME, :JOB_ID
        DO BEGIN
    
        END
    RETURN TRUE;
    END; 

----------------------------------------
### Ожидаемый результат для теста [explicit_cursor_for_loop_statement_inside_trigger.sql](explicit_cursor_for_loop_statement_inside_trigger.sql)


    CREATE TRIGGER T_Grade_meaning1
    AFTER INSERT
    ON EMPLOYEES
    AS
        DECLARE C1 CURSOR  FOR
        (SELECT LAST_NAME, JOB_ID FROM EMPLOYEES
        WHERE MANAGER_ID > 120
        ORDER BY LAST_NAME);

        DECLARE VARIABLE LAST_NAME TYPE OF COLUMN EMPLOYEE.LAST_NAME;
        DECLARE VARIABLE JOB_ID TYPE OF COLUMN EMPLOYEE.EMP_NO;
    BEGIN
        FOR SELECT LAST_NAME, JOB_ID FROM EMPLOYEES
        WHERE MANAGER_ID > 120
        ORDER BY LAST_NAME
        INTO :LAST_NAME, :JOB_ID
        DO BEGIN
    
        END
    END /*T_Grade_meaning1*/;

----------------------------------------

### Ожидаемый результат для теста [explicit_cursor_for_loop_statement_inside_package.sql](explicit_cursor_for_loop_statement_inside_package.sql)


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
            DECLARE C1 CURSOR  FOR
            (SELECT LAST_NAME, JOB_ID FROM EMPLOYEES
            WHERE MANAGER_ID > 120
            ORDER BY LAST_NAME);
        
            DECLARE VARIABLE LAST_NAME TYPE OF COLUMN EMPLOYEE.LAST_NAME;
            DECLARE VARIABLE JOB_ID TYPE OF COLUMN EMPLOYEE.EMP_NO;
            BEGIN
                FOR SELECT LAST_NAME, JOB_ID FROM EMPLOYEES
                WHERE MANAGER_ID > 120
                ORDER BY LAST_NAME
                INTO :LAST_NAME, :JOB_ID
                DO BEGIN
            
                END
            RETURN TRUE;
        END
    
        PROCEDURE PP_Grade_meaning1
        AS
            DECLARE C1 CURSOR  FOR
            (SELECT LAST_NAME, JOB_ID FROM EMPLOYEES
            WHERE MANAGER_ID > 120
            ORDER BY LAST_NAME);
        
            DECLARE VARIABLE LAST_NAME TYPE OF COLUMN EMPLOYEE.LAST_NAME;
            DECLARE VARIABLE JOB_ID TYPE OF COLUMN EMPLOYEE.EMP_NO;
            BEGIN
                 FOR SELECT LAST_NAME, JOB_ID FROM EMPLOYEES
                    WHERE MANAGER_ID > 120
                    ORDER BY LAST_NAME
                    INTO :LAST_NAME, :JOB_ID
                DO BEGIN
                    
                END
        END  
    END /*Pack_Grade_meaning1*/;