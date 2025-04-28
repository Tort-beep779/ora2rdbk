SELECT country,
       state,
       city,
       [-unconvertible TO_APPROX_PERCENTILE(city_detail, .25, 'NUMBER')] "25th Percentile"
FROM amt_sold_by_city_mv
ORDER BY country NULLS LAST, state NULLS LAST, city NULLS LAST;