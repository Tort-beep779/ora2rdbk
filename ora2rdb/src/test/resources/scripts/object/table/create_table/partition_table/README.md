**Partitioned table** используются  для улучшения производительности, когда в таблице содержится большое количество данных


------------------------------------------------------------


### [partition_by_hash_index_organization.sql](partition_by_hash_index_organization.sql)

Индексно-организованные таблицы (IOT) имеют первичный ключ(key column) и данные остальных столбцов(non-key column), которые хранятся в виде сбалансированного дерева (B*Tree)

Чтобы создать индексно-организованную таблицу нужно:
* Указать первичный ключ
* указать ключевые слова **ORGANIZATION INDEX**


**INCLUDING week_no** - означает, что столбец week_no будет хранится вместе с ключевыми столбцами, если будет переполнение(можно укзать процент данных, которые будут 
хранится по принципу IOT).

**OVERFLOW** - Указывает, что часть данных будет храниться в отдельном сегменте переполнения, если они не помещаются в индексную часть таблицы

**PARTITION BY HASH (week_no)** - партиционирование таблицы по значение хэш столбца week_no

**PARTITIONS 16** - данные распределяются между 16 секциями

**STORE IN (ts1, ts2, ts3, ts4)** -  задают табличные простанства в которых будут храниться данные

**OVERFLOW STORE IN (ts3, ts6, ts9)** - задают табличные простанства в которых будут храниться данные в случае переполнения

------------------------------------------------------------

### [partition_by_hash_no_store_in.sql](partition_by_hash_no_store_in.sql)


**PARTITION BY HASH(department_id) PARTITIONS 16** - данные будут распределены по значения хэша
и будут храниться в табличном пространстве по умолчанию

------------------------------------------------------------

### [partition_by_hash_par_in_TS.sql](partition_by_hash_par_in_TS.sql)

**STORAGE (INITIAL 10K)** - указывает размер, который выделяется под таблицу 

**PARTITION BY HASH(department_id)** - секционирование по значение хэша

    (PARTITION p1 TABLESPACE ts1, PARTITION p2 TABLESPACE ts2,
     PARTITION p3 TABLESPACE ts1, PARTITION p4 TABLESPACE ts3);

Для каждой партиции выделяется свое табличное пространство

------------------------------------------------------------

### [partition_by_hash_store_in.sql](partition_by_hash_store_in.sql)

    PARTITION BY HASH (id)
    PARTITIONS 4
    STORE IN (gear1, gear2, gear3, gear4);

Данные в таблице распределяются по 4 партициям, которые будут храниться в табличных пространствах
(gear1, gear2, gear3, gear4)

------------------------------------------------------------

### [partition_by_hash_subpartition_by_hash.sql](partition_by_hash_subpartition_by_hash.sql)

    PARTITION BY HASH(department_id)
    SUBPARTITION BY HASH (course_id) SUBPARTITIONS 32 PARTITIONS 16;

оздается 16 партиций, каждая из которых делится еще на 32 подпартиции

------------------------------------------------------------

### [partition_by_list_automatic.sql](partition_by_list_automatic.sql)

    PARTITION BY LIST (sales_state) AUTOMATIC
    (PARTITION P_CAL VALUES ('CALIFORNIA')
**PARTITION BY LIST** - похоже на PARTITION BY RANGE. Только можно передать список (list) значений для каждой партиции

AUTOMATIC -  указываает, что БД будет создавать новые партиции при вставке данных, значение которых не совпадает со
значением **'CALIFORNIA'** 


------------------------------------------------------------
### [partition_by_list_automatic_multicolumn.sql](partition_by_list_automatic_multicolumn.sql)

    PARTITION BY LIST (state, channel)
    (
    PARTITION q1_northwest_direct VALUES (('OR','D'), ('WA','D')),
    PARTITION q1_northwest_indirect VALUES (('OR','I'), ('WA','I')),
    PARTITION q1_southwest_direct VALUES (('AZ','D'),('UT','D'),('NM','D')),
    PARTITION q1_ca_direct VALUES ('CA','D'),
    PARTITION rest VALUES (DEFAULT)
    );

Данные в таблице распределяются по партициям, основываясь на значениях из списка(list)

В партицию **rest** попадут остальные значения, которые не попали в другие партиции

------------------------------------------------------------

### [partition_by_list_index_organization.sql](partition_by_list_index_organization.sql)

Пример индексно-организованной таблицы (см. пример [partition_by_hash_index_organization.sql](partition_by_hash_index_organization.sql))

Секционирование происходит по списку (PARTITION BY LIST) 

    (PARTITION VALUES (1, 2, 3, 4)
    TABLESPACE ts2,
    PARTITION VALUES (5, 6, 7, 8)
    TABLESPACE ts3 OVERFLOW TABLESPACE ts4,
    PARTITION VALUES (DEFAULT)
    TABLESPACE ts5);
Для каждой партиции указано табличное пространство 

------------------------------------------------------------

### [partition_by_list_inmemory_memcompress.sql](partition_by_list_inmemory_memcompress.sql)

    PARTITION BY LIST (nls_territory) (
    PARTITION asia VALUES ('CHINA', 'THAILAND')
    INMEMORY MEMCOMPRESS FOR CAPACITY HIGH,
    PARTITION europe VALUES ('GERMANY', 'ITALY', 'SWITZERLAND')
    INMEMORY MEMCOMPRESS FOR CAPACITY LOW,
    PARTITION rest VALUES (DEFAULT);

**INMEMORY MEMCOMPRESS** - данные партиции будут храниться в INMEMORY MEMCOMPRESS Store 

**FOR CAPACITY HIGH** - данные будут храниться с высокой степенью сжатия

**FOR CAPACITY LOW** - данные будут храниться с низкой степенью сжатия

------------------------------------------------------------

### [partition_by_list_subpartition_by_hash.sql](partition_by_list_subpartition_by_hash.sql)

    PARTITION BY LIST (region)
    SUBPARTITION BY HASH (customer_id) SUBPARTITIONS 8
    ( PARTITION p_northwest VALUES ('OR', 'WA')
    , PARTITION p_southwest VALUES ('AZ', 'UT', 'NM')
    , PARTITION p_northeast VALUES ('NY', 'VM', 'NJ')
    , PARTITION p_southeast VALUES ('FL', 'GA')
    , PARTITION p_northcentral VALUES ('SD', 'WI')
    , PARTITION p_southcentral VALUES ('OK', 'TX')
    );

Секционирование на партиции по списку (LIST) и подпартиции по значениию хэша 
На каждую партицию выделяетс по 8 подпартиций

------------------------------------------------------------

### [partition_by_list_subpartition_by_list.sql](partition_by_list_subpartition_by_list.sql)

Данные секционируются на уровне партиции по списку и на уровне подпартиции по списку


    PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255
    STORAGE(
    BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
    TABLESPACE "SYSAUX"

* PCTFREE 10: Указывает, что 10% каждого блока данных будет зарезервировано для обновлений.
* PCTUSED 40: Указывает, что блок данных будет доступен для вставки новых записей, если его заполненность упадет ниже 40%.
* INITRANS 1: Указывает начальное количество транзакций, которые могут одновременно изменять данные в блоке.
* MAXTRANS 255: Указывает максимальное количество транзакций, которые могут одновременно изменять данные в блоке.
* STORAGE: Настройки хранения:
* BUFFER_POOL DEFAULT: Используется буферный пул по умолчанию.
* FLASH_CACHE DEFAULT: Используется настройка кэширования в flash-памяти по умолчанию.
* CELL_FLASH_CACHE DEFAULT: Используется настройка кэширования в cell flash-памяти по умолчанию.
* TABLESPACE "SYSAUX": Указывает, что таблица будет храниться в табличном пространстве SYSAUX.


* SEGMENT CREATION DEFERRED: Указывает, что сегменты для подпартиций будут созданы только при вставке данных.
* NOCOMPRESS: Указывает, что данные в подпартициях не будут сжаты.

------------------------------------------------------------

### [partition_by_range_subpartition_by_range.sql](partition_by_range_subpartition_by_range.sql)

PARTITION BY RANGE - удобно использовать когда данные можно разделить по диапазонам (например дата/время)

В данном примере происходит разбиение на парции и подпартиции по диапазону стольцов order_date и delivery_date

------------------------------------------------------------

### [partition_by_range_with_compression.sql](partition_by_range_with_compression.sql)

Пример партицирования по диапазону значений (by range)

**COMPRESS** - указывает, что данные в этой партиции будут сжаты 

------------------------------------------------------------

### [partition_by_range_with_interval.sql](partition_by_range_with_interval.sql)

Пример создания таблицы с интервальным типом секционирования.
Это тип секционирования, при котором Oracle автоматически создает новые секции при вставке данных, выходящих за пределы существующих диапазонов.

    INTERVAL (NUMTOYMINTERVAL(1, 'MONTH'))

Указывает, что Oracle будет автоматически создавать новые секции с интервалом в 1 месяц.

Пользователь должен создать как минимум одну партицию (by range) . 

------------------------------------------------------------

### [partition_by_reference.sql](partition_by_reference.sql)

Пример создания Reference-Partitioned  таблицы

**PARTITION BY REFERENCE(order_items_fk)** - Указывает, что таблица order_items будет секционирована по схеме, унаследованной от таблицы orders, на основе внешнего ключа order_items_fk.

Это означает, что таблица order_items будет иметь те же секции, что и таблица orders, и данные будут распределены по секциям в зависимости от значения order_id.

------------------------------------------------------------

### [partition_by_system.sql](partition_by_system.sql)



PARTITION BY SYSTEM: Указывает, что таблица будет секционирована с использованием системного секционирования.

В отличие от других типов секционирования (например, по диапазону, списку или хешу), системное секционирование не использует автоматическое распределение данных на основе значений столбцов.

Вместо этого разработчик или приложение должны явно указывать, в какую секцию вставлять данные.

При вставке данных в таблицу разработчик или приложение должны явно указать, в какую секцию будут вставлены данные.
    
    INSERT INTO system_part_tab1 PARTITION (tb1) VALUES (1, 100);
