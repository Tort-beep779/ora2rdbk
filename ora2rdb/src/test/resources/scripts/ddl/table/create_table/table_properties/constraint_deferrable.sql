CREATE TABLE DEFERRABLE_TABLE (
    customer_id  NUMBER,
    CONSTRAINT fk_customer FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
        DEFERRABLE
);

CREATE TABLE DEFERRABLE_DEFERRED_TABLE (
    customer_id  NUMBER,
    CONSTRAINT fk_customer FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
        DEFERRABLE INITIALLY DEFERRED
);

CREATE TABLE DEFERRABLE_IMMEDIATE_TABLE (
    customer_id  NUMBER,
    CONSTRAINT fk_customer FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
        DEFERRABLE INITIALLY IMMEDIATE
);