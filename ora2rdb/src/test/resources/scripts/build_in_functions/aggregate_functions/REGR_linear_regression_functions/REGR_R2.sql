SELECT empno,
REGR_R2(SYSDATE-hiredate, sal) r2
   FROM emp
   where deptno in (20, 30, 10)
   GROUP BY empno
   ORDER BY empno;