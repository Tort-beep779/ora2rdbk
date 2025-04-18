SELECT empno, deptno, sal,
      VAR_POP(sal) OVER (PARTITION BY deptno ORDER BY sal NULLS LAST
                      RANGE UNBOUNDED PRECEDING) AS rows_avg
FROM emp;