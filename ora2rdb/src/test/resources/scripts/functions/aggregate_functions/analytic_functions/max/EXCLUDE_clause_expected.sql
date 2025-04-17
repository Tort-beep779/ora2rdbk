SELECT empno, deptno, sal,
       MAX(sal) OVER (PARTITION BY deptno ORDER BY sal
                      RANGE 1 PRECEDING [-unconvertible EXCLUDE CURRENT ROW]) AS rows_avg
FROM emp;