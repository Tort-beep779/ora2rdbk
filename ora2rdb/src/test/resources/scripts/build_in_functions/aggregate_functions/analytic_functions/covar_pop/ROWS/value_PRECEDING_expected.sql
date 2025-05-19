SELECT empno, deptno, sal,
       COVAR_POP(CURRENT_DATE - hiredate, sal) OVER (PARTITION BY deptno ORDER BY sal
                      ROWS 1 PRECEDING) AS rows_avg
FROM emp;