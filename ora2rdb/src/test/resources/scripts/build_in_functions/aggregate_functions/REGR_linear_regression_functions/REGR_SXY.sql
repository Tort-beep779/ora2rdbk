SELECT empno,
REGR_SXY(SYSDATE-hiredate, sal) sxy
   FROM emp
   where deptno in (20, 30, 10)
   GROUP BY empno
   ORDER BY empno;