/*CREATE TABLE sales (
    sale_id NUMERIC(34, 8) PRIMARY KEY,
    sale_date DATE,
    amount NUMERIC(34, 8),
    customer_id NUMERIC(34, 8)
)
[-unconvertible PARTITION BY RANGE (sale_date)
INTERVAL (NUMTOYMINTERVAL(1, 'MONTH'))
STORE IN (tb1)
(
    PARTITION p_initial VALUES LESS THAN (TO_DATE('2023-01-01', 'YYYY-MM-DD'))
)];*/