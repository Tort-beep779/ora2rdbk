SELECT [-unconvertible STATS_MW_TEST
         (cust_gender, amount_sold, 'STATISTIC')] z_statistic
  FROM sh.customers c, sh.sales s
  WHERE c.cust_id = s.cust_id;