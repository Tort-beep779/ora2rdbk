
    { physical_attributes_clause
    | logging_clause
    | ONLINE
    | TABLESPACE { tablespace | DEFAULT }
    | index_compression
    | { SORT | NOSORT }
    | REVERSE
    | VISIBLE | INVISIBLE
    | partial_index_clause
    | parallel_clause
    }...

---------------------------------------

## physical_attributes_clause

### [index_with_physical_attributes_clause.sql](index_with_physical_attributes_clause.sql)

    { PCTFREE integer
    | PCTUSED integer
    | INITRANS integer
    | storage_clause
    }...

Параметр PCTFREE устанавливает процент памяти блока, резервируемой для возможных обновлений строк, уже содержащихся в блоке.

Как только блок данных будет заполнен до процента PCTFREE, в этот блок не возможно будет вставить новые строки до тех пор,
пока процент памяти, используемой в этом блоке, не упадет ниже значения параметра PCTUSED.
Параметр PCTUSED задает нижнюю границу, достижение которой вызывает возврат блока данных в список свободных областей.
Оба параметра настраиваются в паре.

Ограничения:

* Сумма PCTFREE и PCTUSED не может превышать 100
* PCTFREE нельзя устанавливать равным 0


INITRANS указывает минимальное количество слотов (записей) для управления транзакциями, которые выделяются для блока данных при его создании.
  
Значение по умолчанию: 1

-------------------------------------

### [index_with_storage_clause.sql](index_with_storage_clause.sql)

    STORAGE (
    INITIAL <размер>                            -- Размер первого экстента
    NEXT <размер>                               -- Размер следующего экстента
    MINEXTENTS <число>                          -- Минимальное количество экстентов
    MAXEXTENTS <число | UNLIMITED>              -- Максимальное количество экстентов или UNLIMITED
    PCTINCREASE <процент>                       -- Процент увеличения размера экстента
    FREELISTS <число>                           -- Количество списков свободных блоков для параллельной обработки
    FREELIST GROUPS <число>                     -- Количество групп списков свободных блоков для параллельной обработки
    BUFFER_POOL {KEEP | RECYCLE | DEFAULT}      -- Указывает, в какой буферный пул помещаются блоки
    FLASH_CACHE {KEEP | NONE | DEFAULT}         -- Используется для флэш-кэша (Exadata)
    CELL_FLASH_CACHE {KEEP | NONE | DEFAULT}    -- Настройка флэш-кэша на уровне хранения (Exadata)
    )

**Предложение по конвертации - удалять этот атрибут**

Ожидаемый результат для теста

    CREATE INDEX emp_ename ON emp(ename)
    IN TABLESPACE PRIMARY ;

-----------------------------------------------------------

## logging_clause

### [index_with_logging_clause.sql](index_with_logging_clause.sql)

    { LOGGING | NOLOGGING }

Логирует создание индекса (если указан атрибут LOGGING) или не логирует
(если указан атрибут NOLOGGING)

Логирование происходит в Redo log файл

[Ссылка на документацию про Redo log](https://docs.oracle.com/en/database/oracle/oracle-database/19/admin/managing-the-redo-log.html#GUID-BC1F1762-0BB1-4218-B7AF-6160C395AAE4:~:text=Index-,11%20Managing%20the%20Redo%20Log,-You%20manage%20the)

**Предложение при конвертации - удалять этот атрибут**

Ожидаемый результат для теста

    CREATE INDEX ord_customer_ix_demo
    ON orders (order_mode)
    IN TABLESPACE PRIMARY ;

--------------------------------------------------------------------------------

## ONLINE

[документация](https://docs.oracle.com/en/database/oracle/oracle-database/19/sqlrf/CREATE-INDEX.html#:~:text=Mode%3A%20Example%22-,ONLINE,-Specify%20ONLINE%20to)

Указывает, что операции DML над таблицей будут разрешены при создании индекса.

**Предложение при конвертации - удалить**

## Tablespace

Если правило TABLESPACE не указано, база данных Oracle создаёт индекс в табличном пространстве владельца схемы,содержащей индекс. 

В РБД в этом случае индекс будет создан в том же табличном пространстве, что и таблица. 
Поэтому **при конвертации CREATE INDEX без TABLESPACE** добавляется выражение **IN TABLESPACE PRIMARY** (в РБД), 
чтобы индекс создался в основном файле базы данных.

### [index_with_attribute_TABLESPACE.sql](index_with_attribute_TABLESPACE.sql)

    TABLESPACE { tablespace | DEFAULT }

Атрибут **TABLESPACE** указываает табличное пространство в котором будет создан индекс

В РБД работает аналогично

--------------------------------------------------------------------------------

### [index_with_attribute_TABLESPACE_DEFAULT.sql](index_with_attribute_TABLESPACE_DEFAULT.sql)

**TABLESPACE DEFAULT** может задаваться для локальный индексов (с атрибутом LOCAL)

Локальный индекс может задаваться для секционированной таблицы

**Необходимо утвердить как конвертировать секционированные таблицы -> затем
как конвертировать локальные индексы и соответственно атрибут TABLESPACE DEFAULT**


--------------------------------------------------------------------------------

##  index_compression

### [index_with_advanced_index_compression.sql](index_with_advanced_index_compression.sql)

[Официальная документация](https://docs.oracle.com/en/database/oracle/oracle-database/19/admin/managing-indexes.html#GUID-8EE6F072-BADE-466B-98E6-30ABDFFCD8A9:~:text=topic%3A%20Creating%20Indexes-,21.3.8%20Creating%20a%20Compressed%20Index,-As%20your%20database)

    { COMPRESS ADVANCED [ LOW | HIGH ] } | NOCOMPRESS

Атрибут **COMPRESS** используется для сжатия данных, что позволяет оптимизировать работу с БД

**Предложение по  конвертации - комментировать атрибут COMPRESS**

Ожидаемый результат для теста

    CREATE INDEX emp_mndp_ix
    ON employees(manager_id, department_id)
    IN TABLESPACE PRIMARY ;

--------------------------------------------------------------------


### [index_with_prefix_compression.sql](index_with_prefix_compression.sql)

    COMPRESS [ integer ] | NOCOMPRESS

Аналогично как для теста [index_with_advanced_index_compression.sql](index_attributes/index_with_advanced_index_compression.sql)

Ожидемый результат для теста

    CREATE INDEX emp_ename ON emp(ename)
    IN TABLESPACE PRIMARY ;


--------------------------------------------------------------------


## { SORT | NOSORT }

[Документация](https://docs.oracle.com/en/database/oracle/oracle-database/19/sqlrf/CREATE-INDEX.html#:~:text=the%20indexing%20property-,SORT%20%7C%20NOSORT,-By%20default%2C%20Oracle)

По умолчанию oracle сортирует строки по возрастанию (ascending order). 

Но можно указать атрибут **NOSORT** если строки в базе уже отсортированы по возратсанию

**Предложение - при конвертации удалять эти атрибуты**


--------------------------------------------------------------------

## REVERSE

Реверсивный индекс меняет порядок байтов, распределяя новые записи по всему индексу, что снижает нагрузку

Несколько статей на эту тему 

* [Первая](https://oracle-base.com/articles/misc/reverse-key-indexes)
* [Вторая](https://www.relationaldbdesign.com/performance-tuning/module4/create-reverse-index.php)

**При конвертации - удалять (?)**

--------------------------------------------------------------------
## VISIBLE | INVISIBLE

### [index_with_attribute_INVISIBLE.sql](index_with_attribute_INVISIBLE.sql)

    VISIBLE | INVISIBLE

Ключевое слово **INVISIBLE** делает индекс невидимым для оптимизатора

При конвертации атрибут INVISIBLE удаляется и добавляется конструкция

    ALTER INDEX EMP_NAME_DPT_IX INACTIVE;

Которая делает индекс невидимым в РБД

Атрибут **VISIBLE** стоит умолчанию. **При конвертации удаляется**

--------------------------------------------------------------------------------

## partial_index_clause

Можно создать только для партицированной таблицы 

    INDEXING { PARTIAL | FULL }

По умолчнанию стоит **FULL**

**Надо решить как конвертирирвать partitioned tables -> затем как конвертировать индекс с таким атрибутом**

--------------------------------------------------------------------------------

## parallel_clause

    { NOPARALLEL | PARALLEL [ integer ] }

**integer** - число потоков, которые будут использоваться для обработки операций.

Если степень не указана, Oracle выбирает её автоматически, исходя из числа доступных CPU и конфигурации

Параметр PARALLEL в Oracle Database используется для включения параллельной обработки запросов или операций на таблице.


**При конвертации - удалять**

--------------------------------------------------------------------------------







