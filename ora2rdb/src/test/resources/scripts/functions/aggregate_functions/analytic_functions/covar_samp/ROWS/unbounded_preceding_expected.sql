SELECT empno, deptno, sal,
       COVAR_SAMP(CURRENT_DATE - hiredate, sal) OVER (PARTITION BY deptno ORDER BY sal
                      ROWS UNBOUNDED PRECEDING) AS rows_avg
FROM emp;