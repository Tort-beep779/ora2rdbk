SELECT empno,
       ename,
       deptno,
       sal,
       CUME_DIST() OVER (ORDER BY sal NULLS LAST) AS cume_dist_sal
FROM   emp;