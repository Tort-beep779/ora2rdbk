CREATE TABLE UNIQUE_TABLE (
    name    VARCHAR2(100),
    CONSTRAINT uq_example_name UNIQUE (name)
);