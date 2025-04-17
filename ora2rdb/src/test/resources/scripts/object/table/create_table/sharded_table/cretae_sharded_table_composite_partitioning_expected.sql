/*CREATE [-unconvertible SHARDED] TABLE sales (
    sale_id NUMERIC(34, 8) NOT NULL,
    cust_id NUMERIC(34, 8) NOT NULL,
    sale_date DATE,
    product_id NUMERIC(34, 8),
    quantity NUMERIC(34, 8),
    amount NUMERIC(12,2)
)
[-unconvertible PARTITION BY RANGE (sale_date)
SUBPARTITION BY CONSISTENT HASH (cust_id)
SUBPARTITIONS AUTO
(
  PARTITION sales_2022 VALUES LESS THAN (DATE '2023-01-01'),
  PARTITION sales_2023 VALUES LESS THAN (DATE '2024-01-01'),
  PARTITION sales_future VALUES LESS THAN (MAXVALUE)
)]
[-unconvertible TABLESPACE SET ts_sales];*/