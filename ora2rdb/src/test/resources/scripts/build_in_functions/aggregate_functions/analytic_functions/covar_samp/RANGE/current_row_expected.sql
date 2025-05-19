SELECT empno, deptno, sal,
       COVAR_SAMP(CURRENT_DATE - hiredate, sal) OVER (PARTITION BY deptno ORDER BY sal
                      RANGE CURRENT ROW) AS rows_avg
FROM emp;