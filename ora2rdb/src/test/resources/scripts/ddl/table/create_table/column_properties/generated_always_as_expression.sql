CREATE TABLE generated_always_as_expression (
    quantity      NUMBER(10, 2),
    unit_price    NUMBER(10, 2),
    total_price   NUMBER(15, 2) GENERATED ALWAYS AS (quantity * unit_price) VIRTUAL
);