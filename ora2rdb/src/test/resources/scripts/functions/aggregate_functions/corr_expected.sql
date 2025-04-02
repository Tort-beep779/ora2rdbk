SELECT job,
    CORR(CURRENT_DATE - hiredate, sal) AS corr_val
	FROM emp
GROUP BY job
ORDER BY job;
