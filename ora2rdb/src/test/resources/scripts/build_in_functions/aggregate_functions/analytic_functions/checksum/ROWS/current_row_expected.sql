/*SELECT empno, deptno, sal,
       [-unconvertible checksum(sal)] OVER (PARTITION BY deptno ORDER BY sal
                      ROWS CURRENT ROW) AS rows_avg
FROM emp;*/