SELECT empno,
REGR_SXX(SYSDATE-hiredate, sal) sxx
   FROM emp
   where deptno in (20, 30, 10)
   GROUP BY empno
   ORDER BY empno;