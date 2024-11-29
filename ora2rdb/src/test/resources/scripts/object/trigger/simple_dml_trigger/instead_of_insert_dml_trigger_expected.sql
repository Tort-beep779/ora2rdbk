-- Warning: this is a row trigger
CREATE OR ALTER TRIGGER order_info_insert
   BEFORE INSERT ON order_info
   AS
--   DECLARE
--     duplicate_info EXCEPTION;
--     PRAGMA EXCEPTION_INIT (duplicate_info, -00001);
BEGIN
INSERT INTO customers
(customer_id, cust_last_name, cust_fist_name)
VALUES (
           new.customer_id,
           new.cust_last_name,
           new.cust_fist_name);
INSERT INTO orders (order_id, order_date, customer_id)
VALUES (
           new.order_id,
           new.order_date,
           new.customer_id);

-- TODO : подумать про exception

--   EXCEPTION
--     WHEN duplicate_info THEN
--       RAISE_APPLICATION_ERROR (
--         num=> -20107,
--         msg=> 'Duplicate customer or order ID');
END ;