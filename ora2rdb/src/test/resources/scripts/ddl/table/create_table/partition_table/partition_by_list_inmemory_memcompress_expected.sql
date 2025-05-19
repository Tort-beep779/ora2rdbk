/*CREATE TABLE list_customers
   ( customer_id             NUMERIC(6)
   , nls_territory           VARCHAR(30)
   , cust_email              VARCHAR(40))
   [-unconvertible PARTITION BY LIST (nls_territory) (
   PARTITION asia VALUES ('CHINA', 'THAILAND')
         INMEMORY MEMCOMPRESS FOR CAPACITY HIGH,
   PARTITION europe VALUES ('GERMANY', 'ITALY', 'SWITZERLAND')
         INMEMORY MEMCOMPRESS FOR CAPACITY LOW,
   PARTITION rest VALUES (DEFAULT)];*/