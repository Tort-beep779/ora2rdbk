/*CREATE TABLE DEFERRABLE_TABLE (
    customer_id  NUMERIC(34, 8),
    CONSTRAINT fk_customer FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
        [-unconvertible DEFERRABLE]
);*/

/*CREATE TABLE DEFERRABLE_TABLE (
    customer_id  NUMERIC(34, 8),
    CONSTRAINT fk_customer FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
        [-unconvertible DEFERRABLE INITIALLY DEFERRED]
);*/

/*CREATE TABLE DEFERRABLE_TABLE (
    customer_id  NUMERIC(34, 8),
    CONSTRAINT fk_customer FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
        [-unconvertible DEFERRABLE INITIALLY IMMEDIATE]
);*/