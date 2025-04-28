SELECT empno, deptno, sal,
       SUM(sal) OVER (PARTITION BY deptno ORDER BY sal
                      ROWS 1 PRECEDING EXCLUDE CURRENT ROW) AS rows_avg
FROM emp;