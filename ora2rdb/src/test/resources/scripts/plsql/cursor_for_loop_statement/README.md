### CURSOR FOR LOOP 

**CURSOR FOR LOOP** можно использовать тогда, когда вы хотите выгрузить и обработать каждую запись курсора. CURSOR FOR LOOP завершится, когда все записи будут извлечены в курсор.

### Синтаксис 

    FOR record_index in cursor_name
    
    LOOP
    
    {...statements...}
    
    END LOOP;

**record_index** – индекс записи

**cursor_name** - имя курсора, из которого вы хотите извлечь записи.

**statements** - код выполняющийся при каждом прохождении через цикл.

### [cursor_for_loop_references_virtual_columns.sql](cursor_for_loop_references_virtual_columns.sql)

В этом тесте используются псевдозаписи **AS ...**  . Поэтому необходимо 
объявить две переменные, названия которых совпадают с именами псевдозаписей 

    declare dream_salary type of column employee.salary;
    declare full_name varchar(50) ; 

### [explicit_cursor_for_loop_statement.sql](explicit_cursor_for_loop_statement.sql)

Пример объявления курсора и обработки его записей через цикл for 

Во время конвертации тело курсора подставляется в цикл. Используетс цикл 
**for select do ...** 

### [implicit_cursor_for_loop_statement.sql](implicit_cursor_for_loop_statement.sql)

В этом тесте курсор объявляется непосредственно в теле цикла 

При конвертации цикл  **for item loop ... end loop** 
заменяется на **for select do** 

### [passing_parameters_to_explicit_cursor_for_loop_statement.sql](passing_parameters_to_explicit_cursor_for_loop_statement.sql)

В ORACLE можно передать параметры в курсор. При конвертации такой курсор комментируется 

Однако при выборке можно передать параметры сразу в цикл 

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

