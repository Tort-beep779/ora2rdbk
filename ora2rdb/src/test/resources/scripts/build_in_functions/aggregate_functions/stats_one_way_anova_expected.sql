SELECT cust_gender,
       [-unconvertible STATS_ONE_WAY_ANOVA(cust_income_level, amount_sold, 'F_RATIO')] f_ratio
  FROM sh.customers c, sh.sales s
  WHERE c.cust_id = s.cust_id
  GROUP BY cust_gender
  ORDER BY cust_gender;