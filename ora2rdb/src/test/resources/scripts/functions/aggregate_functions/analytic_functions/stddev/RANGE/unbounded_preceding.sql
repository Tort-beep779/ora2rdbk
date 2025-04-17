SELECT empno, deptno, sal,
      sttdev(sal) OVER (PARTITION BY deptno ORDER BY sal
                      RANGE UNBOUNDED PRECEDING) AS rows_avg
FROM emp;