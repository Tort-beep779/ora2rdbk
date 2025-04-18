/*CREATE VIEW amt_sold_by_city_mv
AS
SELECT c.country_id country,
       c.cust_state_province state,
       c.cust_city city,
       [-unconvertible APPROX_PERCENTILE_DETAIL(s.amount_sold)] city_detail
FROM customers c, sales s
WHERE c.cust_id = s.cust_id
GROUP BY c.country_id, c.cust_state_province, c.cust_city;*/