SELECT empno,
REGR_SXX(SYSDATE-hiredate, sal)
OVER (PARTITION BY deptno)
sxx
   FROM emp
   where deptno in (20, 30, 10)
   ORDER BY empno;