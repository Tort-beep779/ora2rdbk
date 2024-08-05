CREATE OR REPLACE PACKAGE BODY string_tracker
IS

TYPE Employee_Row IS RECORD (
        emp_row employees%ROWTYPE
    );

   TYPE used_aat IS TABLE OF who_cares_t
                       INDEX BY value_string_t;

   TYPE list_rt IS RECORD (case_sensitive BOOLEAN, list_of_values used_aat);

   TYPE list_of_lists_aat IS TABLE OF list_rt
                                INDEX BY list_name_t;


  TYPE Public_Rec IS RECORD
  (customer                       CF_REP_CUSTOMER_TAB.customer%TYPE,
   "rowid"                        rowid,
   rowversion                     CF_REP_CUSTOMER_TAB.rowversion%TYPE,
   rowkey                         CF_REP_CUSTOMER_TAB.rowkey%TYPE,
   description                    CF_REP_CUSTOMER_TAB.description%TYPE);

    TYPE Employee_Salary IS RECORD (
        emp_id     employees.employee_id%TYPE,
        emp_salary employees.salary%TYPE
    );


    TYPE Department_Row IS RECORD (
        dept_row departments%ROWTYPE
    );


    TYPE Department_Name IS RECORD (
        dept_id   departments.department_id%TYPE,
        dept_name departments.department_name%TYPE
    );


    TYPE Order_Row IS RECORD (
        order_row orders%ROWTYPE
    );


    TYPE Order_Total IS RECORD (
        order_id    orders.order_id%TYPE,
        total_amount orders.order_total%TYPE
    );


    TYPE Customer_Row IS RECORD (
        cust_row customers%ROWTYPE
    );


    TYPE Customer_Name IS RECORD (
        cust_id   customers.customer_id%TYPE,
        cust_name customers.customer_name%TYPE
    );


    TYPE Product_Row IS RECORD (
        prod_row products%ROWTYPE
    );


    TYPE Product_Name IS RECORD (
        product_id   products.product_id%TYPE,
        product_name products.product_name%TYPE
    );

END string_tracker;
/
