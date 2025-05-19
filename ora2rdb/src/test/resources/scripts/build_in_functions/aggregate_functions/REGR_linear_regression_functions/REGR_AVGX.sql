SELECT empno,
REGR_AVGX(SYSDATE-hiredate, sal) avgx
   FROM emp
   where deptno in (20, 30, 10)
   GROUP BY empno
   ORDER BY empno;