SELECT [-unconvertible PERCENT_RANK(15000, .05) WITHIN GROUP
       (ORDER BY salary NULLS LAST, commission_pct NULLS LAST)] "Percent-Rank"
  FROM employees;