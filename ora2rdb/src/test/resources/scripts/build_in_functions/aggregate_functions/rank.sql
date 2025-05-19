SELECT empno,
       ename,
       deptno,
       sal,
       RANK() OVER (ORDER BY sal) AS percent_rank_sal
FROM emp;