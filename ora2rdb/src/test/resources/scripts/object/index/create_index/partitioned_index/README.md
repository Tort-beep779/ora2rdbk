Такие типы индексов нельзя создать в Ред База Данных 

Ниже приведены предложения по конвертации таких индексов


### [hash_partitioned_global_index.sql](hash_partitioned_global_index.sql)

    CREATE INDEX cust_last_name_ix ON customers (cust_last_name)
    IN TABLESPACE PRIMARY ;


### [index_on_hash_partitioned_table.sql](index_on_hash_partitioned_table.sql)


    CREATE INDEX sales_ix ON composite_sales(time_id, prod_id)
    IN TABLESPACE PRIMARY ;

### [index_subpartition_clause.sql](index_subpartition_clause.sql)

    CREATE INDEX sales_ix ON composite_sales(time_id, prod_id)
    IN TABLESPACE PRIMARY ;

### [local_partitioned_index.sql](local_partitioned_index.sql)

    CREATE INDEX product_bm_ix
    ON hash_products(list_price)
    IN TABLESPACE PRIMARY ;

### [range_partitioned_global_index.sql](range_partitioned_global_index.sql)

    CREATE INDEX cost_ix ON sales (amount_sold)
    IN TABLESPACE PRIMARY ;