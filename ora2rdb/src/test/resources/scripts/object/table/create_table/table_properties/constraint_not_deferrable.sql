CREATE TABLE NOT_DEFERRABLE_TABLE (
    customer_id  NUMBER,
    CONSTRAINT fk_customer FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
        NOT DEFERRABLE
);