/*CREATE VIEW monthly_prod_count_mv AS
  SELECT year,
         month,
         [- unconvertible APPROX_COUNT_DISTINCT_AGG(daily_detail)] monthly_detail
  FROM daily_prod_count_mv
  GROUP BY year, month;*/