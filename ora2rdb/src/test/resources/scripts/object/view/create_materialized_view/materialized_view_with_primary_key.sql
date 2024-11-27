CREATE MATERIALIZED VIEW oe.customers WITH PRIMARY KEY
  AS SELECT * FROM oe.customers@orc1.example.com;
