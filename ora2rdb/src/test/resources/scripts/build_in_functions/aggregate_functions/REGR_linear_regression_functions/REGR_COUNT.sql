SELECT empno,
REGR_COUNT(SYSDATE-hiredate, sal) cnt
   FROM emp
   where deptno in (20, 30, 10)
   GROUP BY empno
   ORDER BY empno;