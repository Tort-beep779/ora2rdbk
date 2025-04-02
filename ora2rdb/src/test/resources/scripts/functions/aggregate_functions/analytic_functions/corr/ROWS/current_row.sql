SELECT empno, deptno, sal,
       CORR(SYSDATE - hiredate, sal) OVER (PARTITION BY deptno ORDER BY sal
                      ROWS CURRENT ROW) AS rows_avg
FROM emp;