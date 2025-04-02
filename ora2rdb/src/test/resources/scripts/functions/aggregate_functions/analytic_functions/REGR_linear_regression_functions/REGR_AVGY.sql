SELECT empno,
REGR_AVGY(SYSDATE-hiredate, sal)
OVER (PARTITION BY deptno)
avgy
   FROM emp
   where deptno in (20, 30, 10)
   ORDER BY empno;