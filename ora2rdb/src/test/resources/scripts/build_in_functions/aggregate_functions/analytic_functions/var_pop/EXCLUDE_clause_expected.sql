SELECT empno, deptno, sal,
       VAR_POP(sal) OVER (PARTITION BY deptno ORDER BY sal NULLS LAST
                      ROWS 1 PRECEDING [-unconvertible EXCLUDE CURRENT ROW]) AS rows_avg
FROM emp;