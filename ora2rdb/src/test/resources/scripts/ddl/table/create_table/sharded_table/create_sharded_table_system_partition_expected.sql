/*CREATE [-unconvertible SHARDED] TABLE employees (
    emp_id NUMERIC(34, 8) NOT NULL,
    name VARCHAR(50),
    department VARCHAR(50),
    salary NUMERIC(34, 8)
)
[-unconvertible PARTITION BY SYSTEM (emp_id)
PARTITIONS AUTO]
[-unconvertible TABLESPACE SET ts5];*/