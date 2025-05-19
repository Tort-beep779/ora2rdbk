/*CREATE TABLE departments_courses_hash (
             department_id NUMERIC(4) NOT NULL,
             department_name VARCHAR(30),
             course_id NUMERIC(4) NOT NULL)
     [-unconvertible PARTITION BY HASH(department_id)
     SUBPARTITION BY HASH (course_id) SUBPARTITIONS 32 PARTITIONS 16];*/