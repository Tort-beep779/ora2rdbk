SELECT empno,
       ename,
       deptno,
       sal,
       PERCENT_RANK() OVER (ORDER BY sal ASC) AS percent_rank_sal
FROM emp;