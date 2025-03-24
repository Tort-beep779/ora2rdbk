### [create_sharded_table_composite_hash_key.sql](create_sharded_table_composite_hash_key.sql)

Создание шардированной тарблицы 

Шардирование - метод, при котором данные распределяются между несколькими базами данных(шардами)

**PARTITION BY CONSISTENT HASH (prod_id, category_id)** - данные распределяются между шардами, используя 
consistent хэш

Консистентное хеширование — это метод распределения данных, который минимизирует необходимость перераспределения данных при добавлении или удалении шардов.

Кеширование происходит по двум полям (prod_id, category_id)

**PARTITIONS AUTO** Указывает, что Oracle автоматически создает необходимое количество партиций (секций) в зависимости от количества шардов и распределения данных.

--------------------------------------------------------

### [create_sharded_table_partition_hash.sql](create_sharded_table_partition_hash.sql)

Аналогично как в тесте [create_sharded_table_composite_hash_key.sql](create_sharded_table_composite_hash_key.sql)
только кеширование происходит по одному полю (CustNo)


--------------------------------------------------------

### [create_sharded_table_partitions_number.sql](create_sharded_table_partitions_number.sql)

Аналогично как в тесте [create_sharded_table_partition_hash.sql](create_sharded_table_partition_hash.sql)
только задано ограниченное количество партиций (16)

--------------------------------------------------------

### [create_sharded_table_reference_partition.sql](create_sharded_table_reference_partition.sql)

Создает шардированную таблицу с использованием сектионирование по ссылке

**PARTITION BY REFERENCE (fk_customer);** - Указывает, что таблица orders будет секционирована по схеме, унаследованной от таблицы customers, на основе внешнего ключа fk_customer.

Это означает, что таблица orders будет иметь те же секции, что и таблица customers, и данные будут распределены по секциям в зависимости от значения cust_id.

--------------------------------------------------------

### [create_sharded_table_system_partition.sql](create_sharded_table_system_partition.sql)

Создает шардированную таблицу с системным партиционированием PARTITION BY SYSTEM (emp_id)

Подробности в [файле](../partition_table/README.md)

--------------------------------------------------------


### [cretae_sharded_table_composite_partitioning.sql](cretae_sharded_table_composite_partitioning.sql)


    PARTITION BY RANGE (sale_date)
    SUBPARTITION BY CONSISTENT HASH (cust_id)
    SUBPARTITIONS AUTO
    (
    PARTITION sales_2022 VALUES LESS THAN (DATE '2023-01-01'),
    PARTITION sales_2023 VALUES LESS THAN (DATE '2024-01-01'),
    PARTITION sales_future VALUES LESS THAN (MAXVALUE)
    )
    TABLESPACE SET ts_sales;

Пример создания шардированной таблицы с партицированием по полю sale_date и подпартициями по хэшу

--------------------------------------------------------

### [duplicated_table.sql](duplicated_table.sql)


Количество запросов к базе данных, обрабатываемых одним сегментом, может быть увеличено за счет дублирования таблиц, доступных только для чтения или в основном предназначенных для чтения, во всех сегментах.

Для создания используется ключевое слово **DUPLICATED**
