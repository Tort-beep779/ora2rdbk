CREATE VIEW HyPT_MV
AS SELECT time_id, customer_no, sum(price) as total_price
FROM hybrid_sales
GROUP BY time_id, customer_no;
