CREATE VIEW cal_month_sales_mv
AS SELECT t.calendar_month_desc,  SUM(s.amount_sold) AS dollars
   FROM sales s,  times t WHERE s.time_id = t.time_id
   GROUP BY t.calendar_month_desc;
