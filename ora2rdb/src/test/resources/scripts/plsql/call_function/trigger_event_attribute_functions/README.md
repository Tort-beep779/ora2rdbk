[Документация](https://docs.oracle.com/en/database/oracle/oracle-database/21/lnpls/plsql-triggers.html#GUID-266DBF6D-AA74-490C-ADE5-962C10708C2D:~:text=Client%20Event%20Triggers-,10.15.1%20Event%20Attribute%20Functions,-By%20invoking%20system)

### [ora_sysevent.sql](ora_sysevent.sql)

Функция возвращает названия ddl события или события базы данных на которое сработал триггер
Тип возваращемого значения: **VARCHAR2(20)**

В Ред База Данных можно заменить на 

    RDB$GET_CONTEXT ('DDL_TRIGGER','EVENT_TYPE')

Проблема при конвертации: не на все события DDL или БД на которые может сработать триггер
в Oracle сработает триггер в Ред База Данных

---------------------------------------

### [ora_dict_obj_name.sql](ora_dict_obj_name.sql)

ora_dict_obj_name  - имя объекта метаданных на который сработал триггер 


---------------------------------------

### [ora_dict_obj_type.sql](ora_dict_obj_type.sql)

ora_dict_obj_type - тип объекта метаданных на который  сработал триггер

---------------------------------------
### [ora_sql_txt.sql](ora_sql_txt.sql)


    ora_sql_txt ( sql_text OUT ora_name_list_t)

**PLS_INTEGER:** Number of elements in PL/SQL table

**OUT parameter:** SQL text of triggering statement (broken into multiple collection elements if statement is long)

Аналог в РБД - SQL TEXT 
    
    system_event = RDB$GET_CONTEXT ('DDL_TRIGGER','SQL_TEXT');

