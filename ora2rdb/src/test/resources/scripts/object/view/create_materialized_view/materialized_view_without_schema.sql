CREATE MATERIALIZED VIEW employees
  AS SELECT * FROM hr.employees@orc1.example.com;