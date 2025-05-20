MERGE INTO bonuses T
   USING bonuses2 S
   ON (T.employee_id = S.employee_id)
    WHEN NOT MATCHED AND (S.employee_id < 159)
    THEN INSERT (employee_id, bonus) VALUES (S.employee_id, 200)
    WHEN MATCHED AND S.employee_id < 159
    THEN UPDATE SET bonus = 8000;
