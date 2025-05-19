/*CREATE [-unconvertible SHARDED] TABLE products (
    prod_id NUMERIC(34, 8) NOT NULL,
    category_id NUMERIC(34, 8) NOT NULL,
    name VARCHAR(50),
    price NUMERIC(10,2)
)
[-unconvertible PARTITION BY CONSISTENT HASH (prod_id, category_id)
PARTITIONS AUTO]
[-unconvertible TABLESPACE SET ts3];*/