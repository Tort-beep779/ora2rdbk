## Ora2rdb - версия 0.6

В данной версии конвертера была написана спецификация в виде тестов, которая покрывает синтаксис  конструкций в грамматике Oracle DB (PLSQL):
* Конструкции DDL
  * CREATE TABLE / ALTER TABLE
  * CREATE SEQUENCE
  * CREATE INDEX
  * CREATE PROCEDURE
  * CREATE FUNCTION
  * CREATE TRIGGER
  * CREATE PACKAGE / PACKAGE BODY
  * CREATE TYPE
  * CREATE VIEW / CREATE MATERIALIZED VIEW
* Конструкции DML
  * оператор SELECT
  * оператор INSERT
  * оператор UPDATE
  * оператор DELETE
* Операторы PLSQL
  * секция объявления объектов (declare section)
  * оператор IF-THEN-ELSE
  * цикл WHILE LOOP
  * цикл FOR LOOP
  * цикл FOR LOOP для курсора
  * цикл FOR LOOP для оператора SELECT
  * цикл LOOP
  * оператор CASE
  * операторы перехода
    * CONTINUE
    * EXIT
    * GOTO
    * RETURN
    * NULL
  * вызов процедуры / функции
  * операторы SQL
  * оператор EXECUTE IMMEDIATE
  * методы работы с курсором
    * OPEN
    * CLOSE
    * FETCH
  * типы данных
  * обработка исключений
  * цикл FORALL

----------------------------------------------------------

Тест состоит из двух файлов 
1. <название теста>.sql

Содержит PL/SQL код, который создает объект в СУБД Oracle Database

2. <название теста>_expected.sql

Содержит ожидаемый после конвертации результат - код PSQL, который создает объект 
в СУБД Ред База Данных

Пример теста для оператора CREATE PROCEDURE

файл "procedure_with_OR_REPLACE.sql"

    CREATE OR REPLACE PROCEDURE PROCEDURE_NAME
    IS
    BEGIN
        NULL;
    END;
файл "procedure_with_OR_REPLACE_expected.sql"

    CREATE OR ALTER PROCEDURE PROCEDURE_NAME
    SQL SECURITY DEFINER
    AS
    BEGIN
    
    END;

----------------------------------------------------------

### Ожидаемый результат 

Ожидаемый результат представляет собой файл, содержащий код, который должен получится после конвертации. 
Если существует аналог в Ред Базе Данных - это будет скрипт, который создает объект в базе данных.
Если аналога в Ред База Данных не существует - неконвертируемая конструкция заключается 
в квадратные скобки и помечается ключевым словом **-unconvertible**. Пример 

Создание партицированной шардированной таблицы

Oracle:

    CREATE SHARDED TABLE products (
    prod_id NUMBER NOT NULL,
    category_id NUMBER NOT NULL,
    name VARCHAR2(50),
    price price_type
    )
    PARTITION BY CONSISTENT HASH (prod_id, category_id)
    PARTITIONS AUTO
    TABLESPACE SET ts3;

Ред База Данных:

    /*
    CREATE [-unconvertible SHARDED] TABLE products (
        prod_id NUMERIC(34, 8) NOT NULL,
        category_id NUMERIC(34, 8) NOT NULL,
        name VARCHAR(50),
        price [-unconvertible price_type]
    )
    [-unconvertible PARTITION BY CONSISTENT HASH (prod_id, category_id)
    PARTITIONS AUTO]
    [-unconvertible TABLESPACE SET ts3];
    */
В данном примере есть несколько атрибутов, аналогов которых нет в Ред Базе Данных

* ключевое слово **SHARDED**. В Ред База Данных нельзя создать шардированную таблицу
* тип данных на основе коллекции - **price_type**. В Ред База Данных нельзя создать переменную с типом данных на основе коллекции
* разбиение данных таблицы на партиции (**PARTITION**). В Ред База Данных нельзя создать партицированную таблицу
* указание табличного пространства для партиций (TABLESPACE). В Ред База Данных нельзя разбить данные в таблице на 
партиции и указать для них табличное пространство

----------------------------------------------------------

### Правила составления ожидаемого результата

Если в теле функции/процедуры есть неконвертируемая конструкция - комментируется тело (между BEGIN ... END) и весь блок declare. 

Пример 

Oracle 

    CREATE PROCEDURE PROCEDURE_NAME
    IS
        c1 SYS_REFCURSOR;
        v1 employees%ROWTYPE;
        TYPE t_c2 IS REF CURSOR;
        c2 t_c2;
        v2 test_table%ROWTYPE;
        res PLS_INTEGER := 0;
    BEGIN
        OPEN c1 FOR 'SELECT * FROM employees WHERE job_id = :j' USING 'MANAGER';
        FETCH c1 INTO v1;
        OPEN c2 FOR SELECT * FROM test_table;
        FETCH c2 INTO v2;
        IF c1%ROWCOUNT > 0 THEN res := res + 1;
        END IF;
        IF c2%ROWCOUNT > 0 THEN res := res + 10;
        END IF;
        CLOSE c1;
        CLOSE c2;
    END;

Ред База Данных:

    CREATE PROCEDURE PROCEDURE_NAME
    SQL SECURITY DEFINER
    AS
    /*
        DECLARE c1 [-unconvertible SYS_REFCURSOR];
        DECLARE VARIABLE v1 TYPE OF TABLE employees;
        [-unconvertible TYPE t_c2 IS REF CURSOR];
        DECLARE c2 [-unconvertible t_c2];
        DECLARE VARIABLE v2 TYPE OF TABLE test_table;
        DECLARE res INTEGER = 0;
    */
    BEGIN
    /*
        OPEN :c1 [-unconvertible FOR 'SELECT * FROM employees WHERE job_id = :j' USING 'MANAGER'];
        FETCH :c1 INTO :v1;
        OPEN :c2 [-unconvertible FOR SELECT * FROM test_table];
        FETCH :c2 INTO :v2;
        IF ([-unconvertible :c1%ROWCOUNT] > 0) THEN res = :res + 1;
        IF ([-unconvertible :c2%ROWCOUNT] > 0) THEN res = :res + 10;
        CLOSE :c1;
        CLOSE :c2;
    */
    END;

----------------------------------------------------------

Если неконвертируемая конструкция находится не в блоке declare или теле функции/процедуры, а в ddl - комментируется весь блок ddl.

В примере демонстрируется пример создания процедуры, входные параметры которой невозможно конвертировать в Ред Базу Данных

Oracle

    CREATE OR REPLACE PROCEDURE order_books (
        isbns_in IN  name_varray,
        new_counts_in IN number_varray)
    IS
        res PLS_INTEGER := 0;
    BEGIN
        NULL;
    END;

Ред База Данных

    /*
    CREATE OR ALTER PROCEDURE order_books (
        isbns_in [-unconvertible name_varray],
        new_counts_in [-unconvertible number_varray])
    AS
        DECLARE res INTEGER = 0;
    BEGIN
    
    END;
    */

----------------------------------------------------------

Если неконвертируемая конструкция находится внутри пакета - конструкция комментируется и в объявлении пакета, и в теле пакета 

Пример 

Oracle 

    CREATE OR REPLACE PACKAGE PACKAGE_NAME
    AS
        PROCEDURE order_books (
            isbns_in IN  name_varray,
            new_counts_in IN number_varray);
    END PACKAGE_NAME;
    
    CREATE OR REPLACE PACKAGE BODY PACKAGE_NAME
    AS
        PROCEDURE order_books (
            isbns_in IN  name_varray,
            new_counts_in IN number_varray)
        IS
            res PLS_INTEGER := 0;
        BEGIN
            NULL;
        END;
    END PACKAGE_NAME;

Ред База Данных

    CREATE OR ALTER PACKAGE PACKAGE_NAME
    SQL SECURITY DEFINER
    AS BEGIN
        /*
        PROCEDURE order_books (
            isbns_in [-unconvertible name_varray],
            new_counts_in [-unconvertible number_varray]);
        */
    END;
    
    RECREATE PACKAGE BODY PACKAGE_NAME
    AS BEGIN
    /*
        PROCEDURE order_books (
            isbns_in [-unconvertible name_varray],
            new_counts_in [-unconvertible number_varray])
        AS
            DECLARE res INTEGER = 0;
        BEGIN
           
        END
    */
    END;

----------------------------------------------------------
Если неконвертируемая конструкция находится в ddl-операторе - комментируется весь оператор ddl

Пример 

Oracle:

    CREATE SHARDED TABLE products (
        prod_id NUMBER NOT NULL,
        category_id NUMBER NOT NULL,
        name VARCHAR2(50),
        price price_type
    )
    PARTITION BY CONSISTENT HASH (prod_id, category_id)
    PARTITIONS AUTO
    TABLESPACE SET ts3;

Ред База Данных:

    /*
    CREATE [-unconvertible SHARDED] TABLE products (
        prod_id NUMERIC(34, 8) NOT NULL,
        category_id NUMERIC(34, 8) NOT NULL,
        name VARCHAR(50),
        price [-unconvertible price_type]
    )
    [-unconvertible PARTITION BY CONSISTENT HASH (prod_id, category_id)
    PARTITIONS AUTO]
    [-unconvertible TABLESPACE SET ts3];
    */

----------------------------------------------------------

### Правила написания тестов для операторов PL/SQL


Операторы PL/SQL описывались в следущих конструкциях:
* CREATE PROCEDURE
* CREATE FUNCTION
* CREATE TRIGGER
* В теле анонимного блока
* В функции внутри оператора CREATE PACKAGE BODY
* В процедуре внутри оператора CREATE PACKAGE BODY



----------------------------------------------------------

В каждую директорию, в которой находятся файлы с тестами, добавлен README.md файл 

Правила составления файла README.md:
* Описание тестов отделяется друг от друга чертой (---)
* Описание начинается с названия теста и ссылки на него (### [test_name.sql](test_name.sql))
* Тесты отсортированы по именам в алфавитном порядке

