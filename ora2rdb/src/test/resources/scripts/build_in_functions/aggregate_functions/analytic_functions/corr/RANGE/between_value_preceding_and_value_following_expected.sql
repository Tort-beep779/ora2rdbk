SELECT empno, deptno, sal,
       CORR(CURRENT_DATE - hiredate, sal) OVER (PARTITION BY deptno ORDER BY sal
                      RANGE BETWEEN 1 PRECEDING AND 2 FOLLOWING) AS rows_avg
FROM emp;