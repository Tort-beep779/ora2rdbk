/*SELECT empno, deptno, sal,
       [-unconvertible VARIANCE(sal)] OVER (PARTITION BY deptno ORDER BY sal
                      ROWS 1 PRECEDING) AS rows_avg
FROM emp;*/