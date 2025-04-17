SELECT fact_1_id,
       fact_2_id,
       SUM(sales_value) AS sales_value,
       [-unconvertible GROUPING(fact_1_id)] AS f1g,
       [-unconvertible GROUPING(fact_2_id)] AS f2g
FROM   dimension_tab
GROUP BY [-unconvertible CUBE (fact_1_id, fact_2_id)]
ORDER BY fact_1_id, fact_2_id;