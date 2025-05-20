CREATE TABLE FK_TABLE (
    department  NUMBER,
    CONSTRAINT fk_department FOREIGN KEY (department) REFERENCES departments(department_id)
    ON DELETE CASCADE
);