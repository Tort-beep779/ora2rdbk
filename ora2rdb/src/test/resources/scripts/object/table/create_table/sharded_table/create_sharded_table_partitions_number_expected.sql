/*CREATE [-unconvertible SHARDED] TABLE orders (
    order_id NUMERIC(34, 8) NOT NULL,
    cust_id NUMERIC(34, 8) NOT NULL,
    status VARCHAR(10),
    order_date DATE
)
[-unconvertible PARTITION BY CONSISTENT HASH (order_id)
PARTITIONS 16]
[-unconvertible TABLESPACE SET ts2];*/