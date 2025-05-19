SELECT empno, deptno, sal,
      COVAR_POP(SYSDATE - hiredate, sal) OVER (PARTITION BY deptno ORDER BY sal
                      RANGE UNBOUNDED PRECEDING) AS rows_avg
FROM emp;