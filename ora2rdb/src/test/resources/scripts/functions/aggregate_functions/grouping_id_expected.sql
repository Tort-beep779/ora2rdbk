SELECT fact_1_id,
       fact_2_id,
       SUM(sales_value) AS sales_value,
       [-unconvertible GROUPING_ID(fact_1_id, fact_2_id)] AS grouping_id
FROM   dimension_tab
GROUP BY [-unconvertible CUBE (fact_1_id, fact_2_id)]
ORDER BY fact_1_id, fact_2_id;