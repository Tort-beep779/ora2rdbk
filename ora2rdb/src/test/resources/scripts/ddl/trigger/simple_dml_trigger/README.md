### Синтаксис в Oracle Database

    CREATE [OR REPLACE] TRIGGER имя_триггера
        {BEFORE | AFTER}
        {INSERT | DELETE | UPDATE | UPDATE OF список_столбцов } ON имя_таблицы
    [FOR EACH ROW]
    [WHEN (...)]
    [DECLARE ... ]
    BEGIN
        ...исполняемые команды...
    [EXCEPTION ... ]
    END [имя_триггера];


-------------------------------------------------

### [after_trigger.sql](after_trigger.sql) и [before_trigger.sql](before_trigger.sql)

    { BEFORE | AFTER } dml_event_clause 

**Триггер AFTER.** Выполняется для отдельной команды SQL, которая может обраба-
тывать одну или более записей базы данных (например, AFTER UPDATE).

**Триггер BEFORE.** Вызывается до внесения каких-либо изменений (например,
BEFORE INSERT).

В РБД работает аналогично 

-------------------------------------------------
### [crossedition_trigger.sql](crossedition_trigger.sql)

    { FORWARD | REVERSE } CROSSEDITION 

[Документация](https://docs.oracle.com/en/database/oracle/oracle-database/21/adfns/editions.html#GUID-474231E0-F8D7-4E39-86F5-BCC52FACEB37:~:text=about%20using%20hints-,28.5%20Crossedition%20Triggers,-The%20most%20important)

**Crossedition triggers** — служат для межредакционного взаимодействия, например для переноса и трансформации данных из полей, отсутствующих в новой редакции, в другие поля.

Разница с обычными триггерами, в том как они взаимодействуют с редакциями (edition)

Forward crossedition triggers перемещают данные из столбцов, используемых в старой редакции, в столбцы, используемые в новой редакции; 

REVERSE crossediition trigger  выполняют обратное действие.

**Предложение - при конвертации комментировать этот атрибут** 
 
Ожидаемый результат 

    CREATE TRIGGER TRIGGER1
    BEFORE INSERT ON TABLE1
    /*CROSSEDITION*/
    SQL SECURITY DEFINER
    AS
    BEGIN
    
    END;

-------------------------------------------------

### [FOR_EACH_ROW_trigger.sql](FOR_EACH_ROW_trigger.sql)

    FOR EACH ROW

Если задана секция **FOR EACH ROW**, триггер будет запускаться для каждой обрабатываемой
командой строки. Но если эта секция отсутствует, по умолчанию триггер будет запускаться
только по одному разу для каждой команды (то есть будет создан триггер уровня команды)

В РБД триггер всегда срабатывает для каждой строки 

При конвертации атрибут **FOR EACH ROW** можно удалить

Однако если атрибут не указан, нужно выдать предупреждение для пользователя 

    -- WARNING: THIS IS A ROW TRIGGER

-------------------------------------------------

### [instead_of_insert_dml_trigger.sql](instead_of_insert_dml_trigger.sql)

    INSTEAD OF { DELETE | INSERT | UPDATE } 

**Триггеры INSTEAD OF.** Замещающие триггеры (триггеры INSTEAD OF) являются
альтернативой триггерам DML. Они запускаются непосредственно перед операци-
ями вставки, обновления, удаления, и их код определяет, какие действия следует
выполнить вместо соответствующей операции DML. 

Триггеры INSTEAD OF управляют операциями над представлениями, но не над таблицами. С их помощью можно преобразовывать необновляемые представления в обновляемые, 
изменяя при необходимости их поведение

[Ссылка](https://docs.oracle.com/en/database/oracle/oracle-database/21/lnpls/plsql-triggers.html#GUID-9F06D45C-7C60-434E-A597-114A0C445671:~:text=END%20CASE%3B%0AEND%3B%0A/-,10.3.2%20INSTEAD%20OF%20DML%20Triggers,-An%20INSTEAD%20OF) 
на документацию

-------------------------------------------------

### [instead_of_trigger_nested_table.sql](instead_of_trigger_nested_table.sql)

[Пример](https://docs.oracle.com/en/database/oracle/oracle-database/21/lnpls/plsql-triggers.html#GUID-9F06D45C-7C60-434E-A597-114A0C445671__CIHFBGDC:~:text=Example%2010%2D3%20INSTEAD%20OF%20Trigger%20on%20Nested%20Table%20Column%20of%20View)
из документации


-------------------------------------------------

### [trigger_ordering_clause.sql](trigger_ordering_clause.sql)

    { FOLLOWS | PRECEDES } [ schmema.] trigger [ , [ schmema.] trigger ]... 

При попмощи ключевых слов  **FOLLOWS | PRECEDES** можно задать порядок срабатывания 
триггеров. 

В РБД для этих целей существует ключевое слово POSITION . Однако стоит задать порядок для каждого триггера

-------------------------------------------------

### [trigger_with_referencing_clause.sql](trigger_with_referencing_clause.sql)

    REFERENCING
    { OLD [ AS ] old
    | NEW [ AS ] new
    | PARENT [ AS ] parent
    }...

С помощью секции REFERENCING в триггере можно менять имена псевдозаписей данных;
это помогает писать самодокументированный код, ориентированный на конкретное
приложение.

В РБД нет такой возможности. Необходимо исправлять код в теле триггера

-------------------------------------------------

### [when_condition.sql](when_condition.sql)

 ` WHEN ( condition ) `

Предложение WHEN предназначено для уточнения условий, при которых должен вы-
полняться код триггера.

В РБД можно заменить условным выражением. Например 

    IF (NEW.NAME = 'СПЛИНТЕР' AND OLD.ESSENCE = 'КРЫСА' AND NEW.ESSENCE = 'СЭНСЭЙ') THEN BEGIN

    END

