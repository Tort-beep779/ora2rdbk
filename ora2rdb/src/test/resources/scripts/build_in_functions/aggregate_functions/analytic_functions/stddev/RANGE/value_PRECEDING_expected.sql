SELECT empno, deptno, sal,
       [-unconvertible sttdev(sal) OVER (PARTITION BY deptno ORDER BY sal
                      RANGE 1 PRECEDING)] AS rows_avg
FROM emp;