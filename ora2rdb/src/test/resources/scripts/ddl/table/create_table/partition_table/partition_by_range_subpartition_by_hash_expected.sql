/*CREATE TABLE sales
  ( prod_id       NUMERIC(6)
  , cust_id       NUMERIC(34, 8)
  , time_id       DATE
  , channel_id    CHAR(1)
  , promo_id      NUMERIC(6)
  , quantity_sold NUMERIC(3)
  , amount_sold   NUMERIC(10,2)
  )
 [-unconvertible PARTITION BY RANGE (time_id) SUBPARTITION BY HASH (cust_id)
  SUBPARTITIONS 8 STORE IN (ts1, ts2, ts3, ts4)
 ( PARTITION sales_q1_2006 VALUES LESS THAN (TO_DATE('01-APR-2006','dd-MON-yyyy'))
  , PARTITION sales_q2_2006 VALUES LESS THAN (TO_DATE('01-JUL-2006','dd-MON-yyyy'))
  , PARTITION sales_q3_2006 VALUES LESS THAN (TO_DATE('01-OCT-2006','dd-MON-yyyy'))
  , PARTITION sales_q4_2006 VALUES LESS THAN (TO_DATE('01-JAN-2007','dd-MON-yyyy'))
 )];*/