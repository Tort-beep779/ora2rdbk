/*SELECT empno, deptno, sal,
       CORR(CURRENT_DATE - hiredate, sal) OVER (PARTITION BY deptno ORDER BY sal
                      RANGE 1 PRECEDING EXCLUDE CURRENT ROW) AS rows_avg
FROM emp;*/