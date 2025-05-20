### [bitmap_index.sql](bitmap_index.sql)

Битовые индексы используют битовые карты для указания значения индексированного столбца. Это идеальный индекс для столбца с низкой кардинальностью (число уникальных записей в таблице мало) при при большом размере таблицы

В РБД используются индексы на основе B-деревьев

**Предложение по конвертации - комментировать** 

Ожидаемый результат для теста 

    /* Red database use b-tree indexes
    /*CREATE INDEX idx_product_status ON products(status) IN TABLESPACE PRIMARY ;*/


--------------------------------------------------------------------------------

### [bitmap_join_index.sql](bitmap_join_index.sql)

Может использоваться для ускорения join запросов. Например такой индекс 

    CREATE BITMAP INDEX cust_sales_bji
    ON    sales(customers.state)
    FROM  sales, customers
    WHERE sales.cust_id = customers.cust_id;

Хорошо подойдет для подобного select 

    SELECT SUM(sales.dollar_amount)
    FROM   sales,
    customer
    WHERE  sales.cust_id  = customer.cust_id
    AND    customer.state = 'California';

**Предложение по конвертации - комментировать**

Ожидаемый результат для теста 

    /*CREATE BITMAP INDEX cust_sales_bji
    ON    sales(customers.state)
    FROM  sales, customers
    WHERE sales.cust_id = customers.cust_id;*/

--------------------------------------------------------------------------------

### [cluster_index_clause.sql](cluster_index_clause.sql)

    CLUSTER [ schema. ] cluster index_attributes

Создает индекс для кластера 

[Создание кластера в ORACLE](https://docs.oracle.com/en/database/oracle/oracle-database/23/sqlrf/CREATE-CLUSTER.html?source=%3Aex%3Apw%3A%3A%3A%3A%3ATNS_SQL_2_D#GUID-4DBC701F-AFC3-486D-AA32-B5CB1D6946F7)

[Ссылка на пример в официальной документации](https://docs.oracle.com/en/database/oracle/oracle-database/23/sqlrf/CREATE-INDEX.html?source=%3Aex%3Apw%3A%3A%3A%3A%3ATNS_SQL_2_D#GUID-1F89BBC0-825F-4215-AF71-7588E31D8BFE__I2129513:~:text=order_mode)

**Предложение при конвертации - комментировать** 

**Ожидаемый результат для теста** 

    /*CREATE INDEX idx_personnel ON CLUSTER personnel;*/

--------------------------------------------------------------------------------


### [functional_index.sql](functional_index.sql)

Вместо столбца можно задать выражение. Такой индекс называется вычисляемым или индексом по выражению.

При конвертации перед выражением добавляется **COMPUTED BY**

--------------------------------------------------------------------------------


### [index_with_ASC_attribute_in_first_column.sql](index_with_ASC_attribute_in_first_column.sql)

В ORACLE можно для каждого столбца задать направление сортировки 

**При конвертации брать сортировку первого столбца** 

--------------------------------------------------------------------------------

### [index_with_DESC_attribute_in_first_column.sql](index_with_DESC_attribute_in_first_column.sql)

Аналогично как для [index_with_ASC_attribute_in_first_column.sql](index_with_ASC_attribute_in_first_column.sql)

--------------------------------------------------------------------------------

### [index_with_INDEXTYPE_attribute.sql](index_with_INDEXTYPE_attribute.sql)

    INDEXTYPE IS { domain_index_clause
    | XMLIndex_clause } 

[create indextype](https://docs.oracle.com/en/database/oracle/oracle-database/23/sqlrf/CREATE-INDEXTYPE.html?source=%3Aex%3Apw%3A%3A%3A%3A%3ATNS_SQL_2_D)

Атрибут указыается для domain index 

**Domain indexes,** which are instances of an application-specific index of type indextype.

[Domain indexes](https://docs.oracle.com/en/database/oracle/oracle-database/19/addci/building-domain-indexes.html#GUID-E370B5E4-BAC0-49C6-B17D-830B3A507FB4)

**Подумать над конвертацией**
------------------------------------------------------------------------------------------------------------------

### [index_with_INVALIATION.sql](index_with_INVALIATION.sql)

Условие позволяет контролировать, когда база данных делает недействительными зависимые курсоры:  
при перестроении индекса или при пометке индекса UNUSABLE

[Ссылка на документацию](https://docs.oracle.com/en/database/oracle/oracle-database/23/sqlrf/ALTER-INDEX.html?source=%3Aex%3Apw%3A%3A%3A%3A%3ATNS_SQL_2_D#GUID-D8F648E7-8C07-4C89-BB71-862512536558__DEFERREDIMMEDIATEINVALIDATION-42A7C77E:~:text=%7B%20DEFERRED%20%7C%20IMMEDIATE%20%7D%20INVALIDATION)

**Предложение при конвертации - удалять это условие** 

Ожидаемый результат для теста 

    create index i on countries(country_name) 
    IN TABLESPACE PRIMARY;

------------------------------------------------------------------------------------------------------------------

### [mixed_index.sql](mixed_index.sql)

В ORACLE есть возможность создавать 'смешанный' индекс - выражение + столбец

**При конвертации - удалять/комментировать** 


------------------------------------------------------------------------------------------------------------------

### [unique_index.sql](unique_index.sql)

Ключевое слово UNIQUE указывает на то, что 
в таблицу нельзя будет добавить несколько строк с одинаковыми значениями ключа индекса.

------------------------------------------------------------------------------------------------------------------

### [UNUSABLE_index.sql](UNUSABLE_index.sql)

    USABLE | UNUSABLE

Ключевое слово **UNUSABLE** делает индекс невидимым для оптимизатора. Такой индекс можно будет удалить или пересоздать

При конвертации UNUSABLE удаляется и добавляется конструкция

    ALTER INDEX I INACTIVE;
    
Ключеовое слово USABLE стоит по умолчанию. ПРи конвертации удаляется




