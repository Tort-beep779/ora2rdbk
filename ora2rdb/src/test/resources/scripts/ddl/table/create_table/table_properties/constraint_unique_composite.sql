CREATE TABLE UNIQUE_TABLE (
    name        VARCHAR2(100),
    last_name   VARCHAR2(100),
    CONSTRAINT uq_example_name UNIQUE (name, last_name)
);
