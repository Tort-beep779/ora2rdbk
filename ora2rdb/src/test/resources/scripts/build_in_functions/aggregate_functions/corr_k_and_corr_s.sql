SELECT COUNT(*) count,
       CORR_S(salary, commission_pct) commission,
       CORR_K(salary, commission_pct, 'TWO_SIDED_SIG') two_sided_p_value
  FROM employees;