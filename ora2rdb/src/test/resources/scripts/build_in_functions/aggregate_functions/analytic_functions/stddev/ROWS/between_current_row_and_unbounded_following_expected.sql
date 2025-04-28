SELECT empno, deptno, sal,
       [-unconvertible sttdev(sal) OVER (PARTITION BY deptno ORDER BY sal
                      ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)] AS rows_avg
FROM emp;