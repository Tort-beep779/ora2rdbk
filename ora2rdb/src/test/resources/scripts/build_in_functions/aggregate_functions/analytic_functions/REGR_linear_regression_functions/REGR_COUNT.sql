SELECT empno,
REGR_COUNT(SYSDATE-hiredate, sal)
OVER (PARTITION BY deptno)
cnt
   FROM emp
   where deptno in (20, 30, 10)
   ORDER BY empno;