SELECT empno,
REGR_AVGY(SYSDATE-hiredate, sal) avgy
   FROM emp
   where deptno in (20, 30, 10)
   GROUP BY empno
   ORDER BY empno;