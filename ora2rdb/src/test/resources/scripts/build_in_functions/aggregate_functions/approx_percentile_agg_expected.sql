/*CREATE VIEW amt_sold_by_state_mv AS
SELECT country,
       state,
       [-unconvertible APPROX_PERCENTILE_AGG(city_detail)] state_detail
FROM amt_sold_by_city_mv
GROUP BY country, state;*/