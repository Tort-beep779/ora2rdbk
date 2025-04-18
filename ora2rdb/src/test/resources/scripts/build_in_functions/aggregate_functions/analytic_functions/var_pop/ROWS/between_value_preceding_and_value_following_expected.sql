SELECT empno, deptno, sal,
       VAR_POP(sal)  OVER (PARTITION BY deptno ORDER BY sal NULLS LAST
                      ROWS BETWEEN 1 PRECEDING AND 2 FOLLOWING) AS rows_avg
FROM emp;