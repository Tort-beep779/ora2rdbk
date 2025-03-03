SELECT time_hier.member_name as TIME,
 sales,
 units
FROM
    sales_av HIERARCHIES(time_hier)
WHERE time_hier.level_name = 'YEAR'
ORDER BY time_hier.hier_order;
