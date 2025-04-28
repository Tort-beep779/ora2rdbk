MERGE INTO bonuses 
   USING bonuses2
   ON (bonuses.employee_id = bonuses2.employee_id)
    WHEN NOT MATCHED AND (bonuses2.employee_id < 159) 
    THEN INSERT (employee_id, bonus) VALUES (bonuses2.employee_id, 1);