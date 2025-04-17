SELECT empno,
       ename,
       deptno,
       sal,
       RANK() OVER (ORDER BY sal NULLS LAST) AS percent_rank_sal
FROM   emp;