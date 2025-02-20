### [explicit_cursor_definition_with_parameter.sql](explicit_cursor_definition_with_parameter.sql)

**Ожидаемый результат** 

    /*ERROR: RED DATABASE DOES NOT SUPPORT CURSOR WITH PARAMETER*/
    CREATE FUNCTION function_name
    RETURN BOOLEAN
    AS
        /*CURSOR cursor_name(input_parameter IN VARCHAR2) IS
        SELECT * FROM employees
        WHERE first_name = input_parameter;*/
    BEGIN
    
    END;

В РБД не поддерживается создание курсора в который можно передавать параметры. 
На данный предложение - комментировать такой случай. 

------------------------

### [cursor_with_return_statement.sql](cursor_with_return_statement.sql)

В секции RETURN могут быть указаны любые из следующих структур данных:

* Запись, определяемая на основе строки таблицы данных с помощью атрибута %ROWTYPE.
* Запись, определяемая на основе другого, ранее объявленного курсора, также с помощью атрибута %ROWTYPE.
* Запись, определенная программистом.

**Предложение : удалять эту секцию при конвертации**

