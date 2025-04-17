SELECT empno,
       ename,
       deptno,
       sal,
       CUME_DIST() OVER (ORDER BY sal) AS cume_dist_sal
FROM   emp;