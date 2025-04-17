SELECT empno, deptno, sal,
       CORR(SYSDATE - hiredate, sal) OVER (PARTITION BY deptno ORDER BY sal
                      ROWS 1 PRECEDING) AS rows_avg
FROM emp;