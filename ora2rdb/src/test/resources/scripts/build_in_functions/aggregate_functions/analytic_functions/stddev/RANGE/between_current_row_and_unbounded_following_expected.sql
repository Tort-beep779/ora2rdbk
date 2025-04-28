SELECT empno, deptno, sal,
       [-unconvertible sttdev(sal) OVER (PARTITION BY deptno ORDER BY sal
                      RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)] AS rows_avg
FROM emp;