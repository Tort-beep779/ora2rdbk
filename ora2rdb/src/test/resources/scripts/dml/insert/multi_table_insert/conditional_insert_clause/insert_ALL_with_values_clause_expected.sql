--при конвертации обратить внимание на порядок в select
INSERT INTO SMALL_ORDERS(ORDER_ID, ORDER_TOTAL, SALES_REP_ID , CUSTOMER_ID)
    SELECT o.order_id oid,  o.order_total ottl,   o.sales_rep_id sid,  o.customer_id cid
    FROM orders o, customers c
    WHERE o.customer_id = c.customer_id AND ottl <= 100000  ;

INSERT INTO medium_orders(ORDER_ID, ORDER_TOTAL, SALES_REP_ID , CUSTOMER_ID)
    SELECT o.order_id oid,  o.order_total ottl,   o.sales_rep_id sid,  o.customer_id cid
    FROM orders o, customers c
    WHERE o.customer_id = c.customer_id AND ottl > 100000 AND ottl <= 200000  ;