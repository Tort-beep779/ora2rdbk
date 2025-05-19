SELECT empno, deptno, sal,
       checksum(sal) OVER (PARTITION BY deptno ORDER BY sal
                      RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS rows_avg
FROM emp;