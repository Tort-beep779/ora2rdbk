SELECT job,
    CORR(SYSDATE - hiredate, sal) AS corr_val_by_job,
    FROM emp
GROUP BY job
ORDER BY job