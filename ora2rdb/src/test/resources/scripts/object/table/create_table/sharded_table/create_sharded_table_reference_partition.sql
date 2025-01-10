CREATE SHARDED TABLE orders (
    order_id NUMBER NOT NULL,
    cust_id NUMBER NOT NULL,
    order_date DATE,
    total_amount NUMBER(12,2),
    CONSTRAINT fk_customer FOREIGN KEY (cust_id) REFERENCES customers(cust_id)
)
PARTITION BY REFERENCE (fk_customer);