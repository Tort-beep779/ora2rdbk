CREATE MATERIALIZED VIEW oe.orders REFRESH FAST AS
SELECT * FROM oe.orders@orc1.example.com o
WHERE EXISTS
          (SELECT * FROM oe.customers@orc1.example.com c
           WHERE o.customer_id = c.customer_id AND c.credit_limit > 10000);
