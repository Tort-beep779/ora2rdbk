create materialized view salary_mv DEFAULT COLLATION USING_NLS_COMP as
select old_salary, new_salary from SALARY;
