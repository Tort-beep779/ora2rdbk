


CREATE EXCEPTION NO_DATA_FOUND
	'no data found';
SET TERM ^ ;

RECREATE   PACKAGE BODY string_tracker
AS BEGIN 

DECLARE TYPE Employee_Row   (
        emp_row TYPE OF TABLE employees
    );  

   /*TYPE used_aat IS TABLE OF who_cares_t
                       INDEX BY value_string_t;*/  

   DECLARE TYPE list_rt   (case_sensitive BOOLEAN, list_of_values used_aat);  

   /*TYPE list_of_lists_aat IS TABLE OF list_rt
                                INDEX BY list_name_t;*/  


  DECLARE TYPE Public_Rec  
  (customer                       TYPE OF COLUMN CF_REP_CUSTOMER_TAB.customer,
   "rowid"                        rowid,
   rowversion                     TYPE OF COLUMN CF_REP_CUSTOMER_TAB.rowversion,
   rowkey                         TYPE OF COLUMN CF_REP_CUSTOMER_TAB.rowkey,
   description                    TYPE OF COLUMN CF_REP_CUSTOMER_TAB.description);  

    DECLARE TYPE Employee_Salary   (
        emp_id     TYPE OF COLUMN employees.employee_id,
        emp_salary TYPE OF COLUMN employees.salary
    );  


    DECLARE TYPE Department_Row   (
        dept_row TYPE OF TABLE departments
    );  


    DECLARE TYPE Department_Name   (
        dept_id   TYPE OF COLUMN departments.department_id,
        dept_name TYPE OF COLUMN departments.department_name
    );  


    DECLARE TYPE Order_Row   (
        order_row TYPE OF TABLE orders
    );  


    DECLARE TYPE Order_Total   (
        order_id    TYPE OF COLUMN orders.order_id,
        total_amount TYPE OF COLUMN orders.order_total
    );  


    DECLARE TYPE Customer_Row   (
        cust_row TYPE OF TABLE customers
    );  


    DECLARE TYPE Customer_Name   (
        cust_id   TYPE OF COLUMN customers.customer_id,
        cust_name TYPE OF COLUMN customers.customer_name
    );  


    DECLARE TYPE Product_Row   (
        prod_row TYPE OF TABLE products
    );  


    DECLARE TYPE Product_Name   (
        product_id   TYPE OF COLUMN products.product_id,
        product_name TYPE OF COLUMN products.product_name
    );  

  END ;

SET TERM ; ^

