CREATE TABLE departments (
    dept_id NUMBER,
    dept_name VARCHAR2(50),
    location VARCHAR2(50),
    PRIMARY KEY (dept_id)
) CLUSTER dept_emp_cluster (dept_id);