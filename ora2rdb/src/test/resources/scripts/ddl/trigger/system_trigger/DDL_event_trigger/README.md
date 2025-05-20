### События триггеров

Список событий, которые можно связать с триггерами DDL, приведен в табл. 19.1. Лю-
бой триггер DDL может вызываться как до (BEFORE), так и после (AFTER) наступления
указанного события.

| Событие DDL               | Описание                                                                 |
|---------------------------|-------------------------------------------------------------------------|
| ALTER                     | Создание объекта базы данных командой SQL ALTER                         |
| ANALYZE                   | Анализ состояния объекта базы данных командой SQL ANALYZE               |
| ASSOCIATE STATISTICS      | Связывание статистики с объектом базы данных                            |
| AUDIT                     | Включение аудита базы данных командой SQL AUDIT                         |
| COMMENT                   | Создание комментария для объекта базы данных                            |
| CREATE                    | Создание объекта базы данных командой SQL CREATE                        |
| DDL                       | Любое из перечисленных событий                                           |
| DISASSOCIATE STATISTICS   | Удаление статистики, связанной с объектом базы данных                   |
| DROP                      | Удаление объекта базы данных командой SQL DROP                          |
| GRANT                     | Назначение прав командой SQL GRANT                                      |
| NOAUDIT                   | Отключение аудита базы данных командой SQL NOAUDIT                      |
| RENAME                    | Переименование объекта базы данных командой SQL RENAME                  |
| REVOKE                    | Отмена прав командой SQL REVOKE                                         |
| TRUNCATE                  | Очистка таблицы командой SQL TRUNCATE                                   |

В Ред База Данных триггер срабатывает на следующие события 

    <ddl_event_item> ::=
        {CREATE | ALTER | DROP} TABLE
        | {CREATE | ALTER | DROP} PROCEDURE
        | {CREATE | ALTER | DROP} FUNCTION
        | {CREATE | ALTER | DROP} TRIGGER
        | {CREATE | ALTER | DROP} EXCEPTION
        | {CREATE | ALTER | DROP} VIEW
        | {CREATE | ALTER | DROP} DOMAIN
        | {CREATE | ALTER | DROP} ROLE
        | {CREATE | ALTER | DROP} SEQUENCE
        | {CREATE | ALTER | DROP} USER
        | {CREATE | ALTER | DROP} INDEX
        | {CREATE | DROP } COLLATION
        | ALTER CHARACTER SET
        | {CREATE | ALTER | DROP} PACKAGE
        | {CREATE | DROP} PACKAGE BODY
        | {CREATE | ALTER | DROP} MAPPING

Также можно указать **ANY DDL STATEMENT**  , что означает "для любого DDL события"

--------------------------------------------------------

### [create_on_schema_trigger.sql](create_on_schema_trigger.sql)

Триггер сработает на создание любого объекта в схеме базы данных 

Чтобы не перечислять все операторы в заголовке триггера, предлагаю такой вариант. 

Предложение по конвертации 

    CREATE TRIGGER TRG_AFTER_CREATE_TABLE
    AFTER ANY DDL STATEMENT
    SQL SECURITY DEFINER
    AS
    BEGIN
        IF (RDB$GET_CONTEXT ('DDL_TRIGGER','EVENT_TYPE') = 'CREATE')
        THEN BEGIN
    
        END
    END;

Аналогично для операторов ALTER/DROP

--------------------------------------------------------

### [trigger_on_grant_statement.sql](trigger_on_grant_statement.sql)

Пример statement, который нельзя сконвертировать

-- аналогично для TRUNCATE/REVOKE/RENAME/NOAUDIT/DISASSOCIATE STATISTICS/COMMENT/AUDIT/ASSOCIATE STATISTICS/ANALYZE


