SELECT empno,
       ename,
       deptno,
       sal,
       PERCENT_RANK() OVER (ORDER BY sal) AS percent_rank_sal
FROM emp;