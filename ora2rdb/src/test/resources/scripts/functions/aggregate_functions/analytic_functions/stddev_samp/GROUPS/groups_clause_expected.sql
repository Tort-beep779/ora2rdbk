SELECT empno, deptno, sal,
       STDDEV_SAMP(sal) OVER (PARTITION BY deptno ORDER BY sal NULLS LAST
                      [-unconverted GROUPS between 1 preceding and current row]) AS rows_avg
FROM emp;