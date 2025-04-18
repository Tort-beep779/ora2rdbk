SELECT COUNT(*) count,
       [-unconvertible CORR_S(salary, commission_pct)] commission,
       [-unconvertible CORR_K(salary, commission_pct, 'TWO_SIDED_SIG')] two_sided_p_value
  FROM employees;