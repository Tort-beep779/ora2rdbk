SELECT empno, deptno, sal,
       VAR_POP(sal) OVER (PARTITION BY deptno ORDER BY sal
                      ROWS CURRENT ROW) AS rows_avg
FROM emp;