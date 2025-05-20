### CURSOR FOR LOOP 

**CURSOR FOR LOOP** можно использовать тогда, когда вы хотите выгрузить и обработать каждую запись курсора. CURSOR FOR LOOP завершится, когда все записи будут извлечены в курсор.

-----------------------------

### Синтаксис 

    FOR record_index in cursor_name
    
    LOOP
    
    {...statements...}
    
    END LOOP;

**record_index** – индекс записи

**cursor_name** - имя курсора, из которого вы хотите извлечь записи.

**statements** - код выполняющийся при каждом прохождении через цикл.

-----------------------------

### [cursor_for_loop_references_virtual_columns.sql](cursor_for_loop_references_virtual_columns.sql)

В этом тесте используются псевдозаписи **AS ...**  . Поэтому необходимо 
объявить две переменные, названия которых совпадают с именами псевдозаписей 

    DECLARE DREAM_SALARY TYPE OF COLUMN EMPLOYEE.SALARY;
    DECLARE FULL_NAME VARCHAR(50) ;

Ожидаемый результат 

    EXECUTE BLOCK  AS
        DECLARE DREAM_SALARY TYPE OF COLUMN EMPLOYEE.SALARY;
        DECLARE FULL_NAME VARCHAR(50) ;
    BEGIN
        FOR
            SELECT FIRST_NAME || ' ' || LAST_NAME AS FULL_NAME,
            SALARY * 10                    AS DREAM_SALARY
            FROM EMPLOYEE
            INTO :FULL_NAME, :DREAM_SALARY  
        DO BEGIN
            FULL_NAME = 'UNKNOWN';
            DREAM_SALARY = 0;
        END
    END;

Необходимо решить, в какой тип конвертировать переменную **FULL_NAME**
, так как она является конкатенацией двух переменных 


-----------------------------

### [passing_parameters_to_explicit_cursor_for_loop_statement.sql](passing_parameters_to_explicit_cursor_for_loop_statement.sql)

В ORACLE можно передать параметры в курсор. При конвертации такой курсор комментируется 

Однако при выборке можно передать параметры сразу в цикл 

Ожидаемый результат 

    /*ERROR: RED DATABASE DOES NOT SUPPORT CURSOR WITH PARAMETER*/
    EXECUTE BLOCK
    AS
        /*CURSOR C1 (JOB VARCHAR2, MAX_WAGE NUMBER) IS
        SELECT LAST_NAME FROM EMPLOYEES
        WHERE JOB_ID = JOB
        AND SALARY > MAX_WAGE;*/

        DECLARE VARIABLE LAST_NAME TYPE OF COLUMN EMPLOYEE.LAST_NAME;
    BEGIN
        FOR SELECT LAST_NAME FROM EMPLOYEE
            WHERE JOB_ID = 'ST_CLERK'
            AND SALARY > 3000
            INTO :LAST_NAME
        DO BEGIN
        
        END
    END;

-----------------------------


### [refer_to_a_variable_inside_for_loop.sql](refer_to_a_variable_inside_for_loop.sql)

В ORACLE можно обращаться к значениям через индекс записи 

Пример 

    FOR ITEM IN C1
      LOOP
        ITEM.LAST_NAME := 'MIKE';  -- REFER TO VARIABLE
    END LOOP;

Через ITEM обращаеся к текущему значению поля LAST_NAME 

При конвертации создаются переменные. В данном случае будет создана переменная **last_name** 
имеющая тип **TYPE OF COLUMN EMPLOYEE.LAST_NAME**

Пример обращения к этой переменной в теле цикла 

    LAST_NAME = 'MIKE';  -- REFER TO VARIABLE

Ожидаемый результат 

    EXECUTE BLOCK
    AS
        DECLARE VARIABLE LAST_NAME TYPE OF COLUMN EMPLOYEE.LAST_NAME;
    BEGIN
        FOR SELECT LAST_NAME
            FROM EMPLOYEE
            INTO :LAST_NAME
        DO
        BEGIN
            LAST_NAME = 'MIKE';  -- REFER TO VARIABLE
        END
    END;


-----------------------------


### [subquery_in_from_clause_of_parent_query.sql](subquery_in_from_clause_of_parent_query.sql)

В тесте демонстируется более сложный запрос (с подзапросом)

Ожидаемый результат

    EXECUTE BLOCK AS
        DECLARE C1 CURSOR FOR (SELECT T1.DEPT_NO, DEPARTMENT, BUDGET
        FROM DEPARTMENT T1,
        ( SELECT DEPT_NO, COUNT(*) AS STAFF
        FROM EMPLOYEE
        GROUP BY DEPT_NO
        ) T2
        WHERE (T1.DEPT_NO = T2.DEPT_NO) AND STAFF >= 5
        ORDER BY BUDGET);
        
        DECLARE VARIABLE DEPARTMENT_ID TYPE OF COLUMN DEPARTMENTS.DEPARTMENT_ID;
        DECLARE VARIABLE DEPARTMENT_NAME  TYPE OF COLUMN DEPARTMENTS.DEPARTMENT_NAME;
        DECLARE VARIABLE BUDGET TYPE OF COLUMN DEPARTMENTS.BUDGET;
        
    BEGIN
        FOR SELECT T1.DEPARTMENT_ID, DEPARTMENT_NAME, BUDGET
            FROM DEPARTMENT T1,
            ( SELECT DEPT_NO, COUNT(*) AS STAFF
            FROM EMPLOYEE
            GROUP BY DEPT_NO
            ) T2
            WHERE (T1.DEPARTMENT_ID = T2.DEPARTMENT_ID) AND STAFF >= 5
            ORDER BY BUDGET
            INTO :DEPARTMENT_ID, :DEPARTMENT_NAME, :BUDGET
        DO BEGIN
        
        END
    END;