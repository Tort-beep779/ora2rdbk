CREATE TABLE departments_hash (department_id NUMBER(4) NOT NULL,
             department_name VARCHAR2(30))
     PARTITION BY HASH(department_id) PARTITIONS 16;