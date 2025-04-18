/*CREATE [-unconvertible BITMAP] INDEX cust_sales_bji
ON    [-unconvertible sales(customers.state)
FROM  sales, customers
WHERE sales.cust_id = customers.cust_id];*/