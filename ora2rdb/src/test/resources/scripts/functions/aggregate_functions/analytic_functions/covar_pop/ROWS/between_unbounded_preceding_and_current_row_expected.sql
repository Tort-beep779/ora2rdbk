SELECT empno, deptno, sal, 
       COVAR_POP(CURRENT_DATE - hiredate, sal) OVER (PARTITION BY deptno ORDER BY sal
                      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS rows_avg
FROM emp;