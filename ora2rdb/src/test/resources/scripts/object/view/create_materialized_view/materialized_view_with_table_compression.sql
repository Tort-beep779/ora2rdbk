create materialized view emp_data
pctfree 5 compress
   as select * from example_table2;
