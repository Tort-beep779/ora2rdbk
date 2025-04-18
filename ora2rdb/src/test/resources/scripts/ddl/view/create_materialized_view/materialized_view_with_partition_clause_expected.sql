CREATE VIEW part_sales_mv
AS SELECT s.cust_id, s.time_id,
          SUM(s.amount_sold) AS sum_dol_sales, SUM(s.quantity_sold) AS sum_unit_sales
   FROM sales s GROUP BY s.time_id, s.cust_id;
