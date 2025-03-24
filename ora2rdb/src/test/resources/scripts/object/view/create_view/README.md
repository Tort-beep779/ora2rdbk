### [editioning_view.sql](editioning_view.sql)

[документация](https://docs.oracle.com/en/database/oracle/oracle-database/21/adfns/editions.html#GUID-B027A882-3848-4DA1-ABF3-6F9F0F7EFB0B:~:text=on%20audit%20policies.-,28.4%20Editioning%20Views,-On%20a%20noneditioning)

Редактируемые представления данных (editioning views) отличаются от обычных не только формальным словом **EDITIONING** при создании, 
но и некоторыми техническими свойствами. Они могут строиться на основе единственной таблицы, без фильтрации строк фразой WHERE и с отсутствием преобразований столбцов

Такие представления имеют ограничения 

[Ограничения](https://docs.oracle.com/en/database/oracle/oracle-database/23/sqlrf/CREATE-VIEW.html#GUID-61D2D2B4-DACC-4C7C-89EB-7E50D9594D30__GUID-E89B1B60-CBCB-4C3F-B30C-6B24B7CBD15B:~:text=Restrictions%20on%20Editioning%20Views)

То есть можно создать EDITIONING представленияе  для одной таблицы для разных editions
Это может помочь при внесении изменений в базу данных

[create edition](https://docs.oracle.com/en/database/oracle/oracle-database/21/sqlrf/CREATE-EDITION.html#GUID-6CF92CA1-CAF7-4967-9B34-C02D72C23617:~:text=Index-,CREATE%20EDITION,-Purpose)

Edition позволяет создавать версии одного и того же объекта 

К editionable объектам относятся 

* Synonym
* View
* Function
* Procedure
* Package (specification and body)
* Type (specification and body)
* Library
* Trigger

**Предложение - удалять ключевое слово EDITIONING при конвертации**

------------------------------------------------------------

### [NONEDITIONABLE_view.sql](NONEDITIONABLE_view.sql)

    EDITIONABLE | NONEDITIONABLE

**editionable/noneditionable** задаются для обычных представлений 

По умолчанию стоит **EDITIONABLE**. 

Предложение - удалять ключевые слова **EDITIONABLE | NONEDITIONABLE** при конвертации


### [object_view.sql](object_view.sql)

[Ссылка на пример](https://docs.oracle.com/en/database/oracle/oracle-database/23/sqlrf/CREATE-VIEW.html#GUID-61D2D2B4-DACC-4C7C-89EB-7E50D9594D30__I2126819:~:text=WITH%20READ%20ONLY%3B-,Creating%20an%20Object%20View%3A%20Example,-The%20following%20example)

------------------------------------------------------------

### [read_only_view.sql](read_only_view.sql)

    WITH { READ ONLY}

запрещает опции обновления/удаления/вставки данных через это представление 

В Ред База Данных нельзя задать этот атриибут в операторе create view 

**Предложение при конвертировании - создавать триггер** 

    CREATE EXCEPTION READ_ONLY_VIEW
        'cannot perform a DML operation on a read-only view';
    CREATE OR ALTER VIEW STAFF  AS
        SELECT employee_id, last_name, job_id, manager_id, department_id
    FROM   employees ;
    /*This is a trigger that makes view read only*/
    CREATE TRIGGER STAFF_READ_ONLY_TRIGGER FOR STAFF
    BEFORE INSERT OR UPDATE OR DELETE
    AS BEGIN
        EXCEPTION READ_ONLY_VIEW;
    END;

Перед операциями обновления/удаления/вставки (BEFORE INSERT OR UPDATE OR DELETE)
будет срабатывать триггер, который будет вызывать исключение READ_ONLY_VIEW

Имя триггера : <имя представления>_READ_ONLY_TRIGGER

Имя исключения: READ_ONLY_VIEW

------------------------------------------------------------

### [view_with_BEQUEATH_CURRENT_USER_clause.sql](view_with_BEQUEATH_CURRENT_USER_clause.sql)

    BEQUEATH CURRENT_USER

Атрибут указыаает, что представление выполнится с правами вызывающего пользователя

По умолчанию - DEFINER - **стоит уточнить**

В РБД представление всегда вызывается с правами DEFINER

**Предложение - при конвертации комментировать атрибутт BEQUEATH CURRENT_USER, но выводить предупреждения 
для пользователя**

Ожидаемый результат

    /* some warning message */
    CREATE VIEW STAFF
    /* BEQUEATH CURRENT_USER */
        AS SELECT employee_id, last_name, job_id, manager_id, department_id
    FROM employees ;

Стоит уточнить текст предупреждающего предложения

------------------------------------------------------------

### [view_with_BEQUEATH_DEFIINER_clause.sql](view_with_BEQUEATH_DEFIINER_clause.sql)

    BEQUEATH DEFINER

Атрибут указыаает, что представление выполнится с правами создавшего его пользователя

В РБД представление всегда вызывается с правами DEFINER - **стоит уточнить**

**Предложение - при конвертации комментировать атрибут BEQUEATH DEFINER**

------------------------------------------------------------

### [view_with_check_option.sql](view_with_check_option.sql)

    WITH CHECK OPTION 

Проверяться, удовлетворяют ли новые строки условию, определяющему представление (то есть, проверяется, будут ли новые строки видны через это представление).

В Ред База Данных работает аналогично 

------------------------------------------------------------

### [view_with_collation_clause.sql](view_with_collation_clause.sql)

атрибут **DEFAULT COLLATION** 

Определяет порядок сортировки “linguistic sorting and searching of character data or strings in Oracle Database”  . 
ожет повлиять на порядок вывода данных в представлении (?) , но на саму работу представления не влияет 

**Необходимо выяснить - подобрать пример, может ли повлиять на порядок вывода данных** 

На данный момент ожидаемый результат 

    CREATE VIEW STAFF  AS
    SELECT employee_id, last_name, job_id, manager_id, department_id
    FROM employees ;

------------------------------------------------------------

### [view_with_constraint_definition.sql](view_with_constraint_definition.sql)

    ... CONSTRAINT const_name;

Задает название ограничению 

**Предложение по конвертации - комментировать** 

Ожидаемый результат

    CREATE VIEW STAFF  AS
    SELECT employee_id, last_name, job_id, manager_id, department_id
    FROM employees WITH CHECK OPTION  /* CONSTRAINT CONST_NAME*/;

------------------------------------------------------------

### [view_with_FORCE_attribute.sql](view_with_FORCE_attribute.sql)

В Oracle можно использовать опцию **FORCE** , чтобы принудительно создать представление даже в случае, если исходная таблица (или другие объекты) еще не существует.

**При конвертации это условие удаляется**

Для решения такой проблемы предусмотрен ключ "-r"

**Альтернатива:** самостоятельно менять порядок метаданных в output файле 

------------------------------------------------------------

### [view_with_inline_constraint.sql](view_with_inline_constraint.sql)

    inline_constraint::=
        [ CONSTRAINT constraint_name ]
        { { [ NOT ] NULL
        | UNIQUE   
        | PRIMARY KEY
        | references_clause } [ constraint_state ]
        | CHECK ( condition ) [ constraint_state ] [ precheck_state ]

[View constraint](https://docs.oracle.com/en/database/oracle/oracle-database/23/sqlrf/constraint.html#GUID-1055EA97-BA6F-4764-A15F-1024FD5B6DFE__I1002565:~:text=Index-,constraint,View%20Constraints,-Oracle%20does%20not)

Ограничения носят декларативный характер и должны быть заданы на базовую таблицу

**Предложение -  при конвертации комментировать этот атрибут**

Ожидаемый результат 

    CREATE VIEW EMP_SAL (emp_id, last_name,
        email /*UNIQUE RELY DISABLE NOVALIDATE*/) AS
    SELECT employee_id, last_name, email FROM employees ;

------------------------------------------------------------

### [view_with_INVISIBLE_alias.sql](view_with_INVISIBLE_alias.sql)

    VISIBLE | INVISIBLE

атрибут **visible/invisible** используется для того, чтобы сделать столбец невидимым (независимо от видимости на базовой таблице)
Если явно не обратиться к этому столбцу - его значение не будет показано

Visible стоит по умолчанию 

[документация Ora2rdb](https://docs.google.com/document/d/14GUlt3umQQr0wAKdn404TEwdcouEi1e-8J1mOw1CgQw/edit?tab=t.0)

В документации есть пример работы такого представления

**Предложение - комментировать эти атрибуты при конвертации**

Ожидаемый результат 

    CREATE VIEW DEPARTMENTS_HQ_MAN (department_id, department_name, manager_id /*INVISIBLE*/, location_id) AS
        SELECT department_id, department_name, manager_id, location_id
        FROM departments
    WHERE location_id = 1700 ;

------------------------------------------------------------

### [view_with_outline_constraint.sql](view_with_outline_constraint.sql)

    out_of_line_constraint::=
        [ CONSTRAINT constraint_name ]
        { { UNIQUE (column [, column ]...)
        | PRIMARY KEY (column [, column ]...)  
        | FOREIGN KEY (column [, column ]...) references_clause }
        [ constraint_state ]
        | CHECK ( condition ) [ constraint_state ] [ precheck_state ] }

Ограничения носят декларативный характер и должны быть заданы на базовую таблицу

**Предложение -  при конвертации комментировать этот атрибут**

Ожидаемый результат

    CREATE VIEW EMP_SAL (emp_id, last_name,
    /*CONSTRAINT id_pk PRIMARY KEY (emp_id)*/ ) AS
    SELECT employee_id, last_name FROM employees ;

------------------------------------------------------------

### [view_with_REPLACE_attribute.sql](view_with_REPLACE_attribute.sql)

Атрибут **OR REPLACE** пересоздаёт представление, если оно уже было создано или создает новое представление

Аналог в РБД - **OR ALTER**

**Уточнить** - если атрибут OR REPLACE не указан - конвертировать в CREATE VIEW или CREATE OR ALTER VIEW 


------------------------------------------------------------

### [view_with_SHARING_clause.sql](view_with_SHARING_clause.sql)

[Документация](https://docs.oracle.com/en/database/oracle/oracle-database/23/sqlrf/CREATE-VIEW.html#GUID-61D2D2B4-DACC-4C7C-89EB-7E50D9594D30__I2126819:~:text=View%3A%20Example%22-,SHARING,-This%20clause%20applies_)

    SHARING = { METADATA | DATA | EXTENDED DATA | NONE }

If you omit this clause, then the database uses the value of the DEFAULT_SHARING initialization parameter to determine the sharing attribute of the view. If the DEFAULT_SHARING initialization parameter does not have a value, then the default is METADATA.

When creating a conventional view, you can specify METADATA, DATA, EXTENDED DATA, or NONE.

When creating an object view or an XMLTYPE view, you can specify only METADATA or NONE.

**Предложение - удалять атрибут при конвертации** 

------------------------------------------------------------

### [xml_type_view.sql](xml_type_view.sql)

[Документация](https://docs.oracle.com/en/database/oracle/oracle-database/23/sqlrf/CREATE-VIEW.html#GUID-61D2D2B4-DACC-4C7C-89EB-7E50D9594D30__I2126819:~:text=data%20dictionary%20views-,XMLType_view_clause,-Use%20this%20clause)

------------------------------------------------------------
