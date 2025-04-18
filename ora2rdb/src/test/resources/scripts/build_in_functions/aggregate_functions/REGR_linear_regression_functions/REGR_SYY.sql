SELECT empno,
REGR_SYY(SYSDATE-hiredate, sal) syy
   FROM emp
   where deptno in (20, 30, 10)
   GROUP BY empno
   ORDER BY empno;