CREATE TABLE employees (
  bonus NUMERIC(34, 8) CHECK (bonus >= 0)
);