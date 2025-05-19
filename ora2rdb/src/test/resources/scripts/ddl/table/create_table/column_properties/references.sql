CREATE TABLE departments (
    department_id NUMBER PRIMARY KEY
);

CREATE TABLE employees (
    employee_id NUMBER PRIMARY KEY,
    department_id NUMBER REFERENCES departments(department_id)
);
