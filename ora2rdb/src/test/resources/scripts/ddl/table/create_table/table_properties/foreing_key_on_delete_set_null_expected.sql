CREATE TABLE FK_TABLE (
    department  NUMERIC(34, 8),
    CONSTRAINT fk_department FOREIGN KEY (department) REFERENCES departments(department_id)
    ON DELETE SET NULL
);