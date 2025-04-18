SELECT [-unconvertible CUME_DIST(15500, .05) WITHIN GROUP
  (ORDER BY salary NULLS LAST, commission_pct NULLS LAST)] "Cume-Dist of 15500"
  FROM employees;