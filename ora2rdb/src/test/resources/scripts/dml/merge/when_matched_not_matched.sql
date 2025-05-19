MERGE INTO bonuses T
   USING bonuses2 S
   ON (T.employee_id = S.employee_id)
    WHEN NOT MATCHED 
    THEN INSERT (employee_id, bonus) VALUES (S.employee_id, 200)
    WHERE (S.employee_id < 159)
    WHEN MATCHED 
    THEN UPDATE SET bonus = 8000
    WHERE S.employee_id < 159;