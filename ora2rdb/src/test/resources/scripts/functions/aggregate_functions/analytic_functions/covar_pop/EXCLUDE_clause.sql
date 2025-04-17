SELECT empno, deptno, sal,
       COVAR_POP(SYSDATE - hiredate, sal) OVER (PARTITION BY deptno ORDER BY sal
                      RANGE 1 PRECEDING EXCLUDE CURRENT ROW) AS rows_avg
FROM emp;