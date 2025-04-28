/*CREATE TABLE sales_auto_list
(
   salesman_id   NUMERIC(5),
   salesman_name VARCHAR(30),
   sales_state   VARCHAR(20),
   sales_amount  NUMERIC(10),
   sales_date    DATE
)
 [-unconvertible PARTITION BY LIST (sales_state) AUTOMATIC
 (PARTITION P_CAL VALUES ('CALIFORNIA'))];*/