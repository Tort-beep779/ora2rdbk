/*SELECT empno, deptno, sal,
       COUNT(sal) OVER (PARTITION BY deptno ORDER BY sal
                      [-unconverted GROUPS between 1 preceding and current row]) AS rows_avg
FROM emp;*/