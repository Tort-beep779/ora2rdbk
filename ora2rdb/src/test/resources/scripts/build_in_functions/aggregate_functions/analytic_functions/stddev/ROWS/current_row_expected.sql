SELECT empno, deptno, sal,
       [-unconvertible sttdev(sal) OVER (PARTITION BY deptno ORDER BY sal
                      ROWS CURRENT ROW)] AS rows_avg
FROM emp;