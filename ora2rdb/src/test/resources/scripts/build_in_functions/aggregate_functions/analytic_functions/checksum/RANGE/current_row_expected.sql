/*SELECT empno, deptno, sal,
       [-unconvertible checksum(sal)] OVER (PARTITION BY deptno ORDER BY sal
                      RANGE CURRENT ROW) AS rows_avg
FROM emp;*/