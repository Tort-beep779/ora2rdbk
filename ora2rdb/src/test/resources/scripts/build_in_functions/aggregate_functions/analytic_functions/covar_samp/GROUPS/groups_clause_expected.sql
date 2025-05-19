/*SELECT empno, deptno, sal,
       COVAR_SAMP(CURRENT_DATE - hiredate, sal) OVER (PARTITION BY deptno ORDER BY sal
                      [-unconvertible GROUPS between 1 preceding and current row]) AS rows_avg
FROM emp;*/