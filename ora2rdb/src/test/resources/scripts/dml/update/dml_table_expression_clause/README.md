### Синтаксис

    { [ schema. ]
    { table
        [ partition_extension_clause
        | @ dblink
    ]
        | { view | materialized view } [ @ dblink ]
    }
        | ( subquery [ subquery_restriction_clause ] )
        | table_collection_expression
    }

--------------------------------------------------

В тестах используется 

* таблица 

        -- ORACLE
        CREATE TABLE "HR"."BOOKS"
        (	"ISBN" VARCHAR2(13) primary key,
        "TITLE" VARCHAR2(100),
        "PAGE_COUNT" NUMBER
        );
    
        -- РБД 
        CREATE TABLE "BOOKS"
        (	"ISBN" VARCHAR(13) primary key,
        "TITLE" VARCHAR(100),
        "PAGE_COUNT" NUMERIC(34, 8)
        );

* представление

        -- ORACLE
      create view v_books AS select PAGE_COUNT from BOOKS;

        -- РБД 
        create view v_books AS select PAGE_COUNT from BOOKS;

* материализованное представление 

        create materialized view mv_books AS select PAGE_COUNT from BOOKS;

        -- РБД (используется обычное представление)

        create view mv_books AS select PAGE_COUNT from BOOKS;


* Для тестов с подзапросом использовалась таблица READER

        -- ORACLE
        CREATE TABLE "HR"."READER"
        (
        "ISBN" VARCHAR2(13) NOT NULL,
        "FIRST_NAME" VARCHAR2(100) NOT NULL,
        
            CONSTRAINT "FK_READER_BOOKS" FOREIGN KEY ("ISBN")
                REFERENCES "HR"."BOOKS"("ISBN")
                ON DELETE CASCADE
        );
        
        -- РБД
        CREATE TABLE "READER"
        (
        "ISBN" VARCHAR(13) NOT NULL,
        "FIRST_NAME" VARCHAR(100) NOT NULL,
    
        CONSTRAINT "FK_READER_BOOKS" FOREIGN KEY ("ISBN")
            REFERENCES "BOOKS"("ISBN")
            ON DELETE CASCADE
        );


--------------------------------------------



### [update_using_subquery_clause.sql](update_using_subquery_clause.sql)


Обновляет столбец TITLE в таблице BOOKS;

**В РБД можно указать только таблицу или представление (явно) , 
а не ввиде подзапроса** 
        
Можно попробовать заменить представлением (view)

Ожидаемый результат 

    CREATE VIEW view_name AS SELECT TITLE from books;   

    update view_name set TITLE = 'C#';

Неоюходимо подумать над названием представления и стоит ли его удалять сразу после выполнения оператора 
update

--------------------------------------------

### [update_using_subquery_with_subquery.sql](update_using_subquery_with_subquery.sql)
Можно заменить представлением. Ожидаемый результат 

    CREATE VIEW view_name AS
    SELECT
    B."TITLE" AS BOOK_TITLE
    FROM
    "BOOKS" B
    WHERE ISBN =
    (SELECT ISBN FROM READER WHERE FIRST_NAME = 'Ivan Ivanov');
    
    UPDATE view_name SET book_title = 'Pascal';


--------------------------------------------

### dml operations on collections 

[Документация](https://docs.oracle.com/en/database/oracle/oracle-database/19/adobj/operations-on-collection-data-types.html?source=%3Aow%3Alp%3Acpo%3A%3A&source=%3Aow%3Alp%3Acpo%3A%3A&source=%3Aow%3Alp%3Acpo%3A%3A&source=%3Aow%3Alp%3Acpo%3A%3A&source=%3Aow%3Alp%3Acpo%3A%3A&source=%3Aow%3Alp%3Acpo%3A%3A&source=%3Aow%3Alp%3Acpo%3A%3A&source=%3Aow%3Alp%3Acpo%3A%3A&source=%3Aow%3Alp%3Acpo%3A%3A&source=%3Aow%3Alp%3Acpo%3A%3A&source=%3Aow%3Alp%3Acpo%3A%3A&source=%3Aow%3Alp%3Acpo%3A%3A&source=%3Aow%3Alp%3Acpo%3A%3A&source=%3Aow%3Alp%3Acpo%3A%3A&source=%3Aow%3Alp%3Acpo%3A%3A&source=%3Aow%3Alp%3Acpo%3A%3A&source=%3Aow%3Alp%3Acpo%3A%3A&source=%3Aow%3Alp%3Acpo%3A%3A&source=%3Aow%3Alp%3Acpo%3A%3A&source=%3Aow%3Alp%3Acpo%3A%3A&source=%3Aow%3Alp%3Acpo%3A%3A&source=%3Aow%3Alp%3Acpo%3A%3A&source=%3Aow%3Alp%3Acpo%3A%3A&source=%3Aow%3Alp%3Acpo%3A%3A&source=%3Aow%3Alp%3Acpo%3A%3A&source=%3Aow%3Alp%3Acpo%3A%3A&source=%3Aow%3Alp%3Acpo%3A%3A&source=%3Aow%3Alp%3Acpo%3A%3A&source=%3Aow%3Alp%3Acpo%3A%3A&source=%3Aow%3Alp%3Acpo%3A%3A&source=%3Aow%3Alp%3Acpo%3A%3A&source=%3Aow%3Alp%3Acpo%3A%3A&source=%3Aow%3Alp%3Acpo%3A%3A&source=%3Aow%3Alp%3Acpo%3A%3A&source=%3Aow%3Alp%3Acpo%3A%3A&source=%3Aow%3Alp%3Acpo%3A%3A&source=%3Aow%3Alp%3Acpo%3A%3A&source=%3Aow%3Alp%3Acpo%3A%3A&source=%3Aow%3Alp%3Acpo%3A%3A&source=%3Aow%3Alp%3Acpo%3A%3A#GUID-C025E6AE-509C-4A0C-AA14-7AF26E140695:~:text=Unnesting%20Queries%22-,5.3.2%20DML%20Operations%20on%20Collections,-Oracle%20supports%20the)

--------------------------------------------

### ключевое слово ONLY 

**The ONLY clause** applies only to views. Specify ONLY syntax if the view in the UPDATE clause is a view that belongs to a hierarchy and you do not want to update rows from any of its subviews.

    UPDATE
    { dml_table_expression_clause
    | ONLY (dml_table_expression_clause)


[Object View Hierarchies](https://docs.oracle.com/en/database/oracle/oracle-database/23/adobj/object-vew-hierarchies.html#GUID-02606831-2C41-4C51-8E18-36191EBDDD05)

--------------------------------------------


### [update_with_subquery_restriction_clause.sql](update_with_subquery_restriction_clause.sql)

Пример из теста вызовет ошибку при попытке обновления данных в таблице ъ

    Error at Command Line : 168 Column : 15
    Error report -
    SQL Error: ORA-01402: представление WITH CHECK OPTION не соответствует фразе WHERE
    01402. 00000 -  "view WITH CHECK OPTION where-clause violation"
           *Cause:    
           *Action:

потому что мы пытаемся вставить значение = 350, при ограничении > 400

--------------------------------------------

### [update_with_subquery_restriction_clause_READ_ONLY.sql](update_with_subquery_restriction_clause_READ_ONLY.sql)

Пример из теста вызовет ошибку

    Error at Command Line : 172 Column : 5
    Error report -
    SQL Error: ORA-42399: невозможно выполнить операцию DML для доступного только для чтения представления
    42399.0000 - "cannot perform a DML operation on a read-only view"

--------------------------------------------

При попытке выполнить этот скрипт. 

    UPDATE (
    SELECT "ISBN", "PAGE_COUNT"
    FROM "HR"."BOOKS"
    WHERE "PAGE_COUNT" > 400
    WITH CHECK OPTION constraint my_cnstr
    )
    SET "PAGE_COUNT" = 410;

То есть явно задать ограничение **my_cnstr** выдает эту ошибку 

    Error at Command Line : 170 Column : 23
    Error report -
    SQL Error: ORA-00907: отсутствует правая скобка
    00907. 00000 -  "missing right parenthesis"
           *Cause:    
           *Action:



