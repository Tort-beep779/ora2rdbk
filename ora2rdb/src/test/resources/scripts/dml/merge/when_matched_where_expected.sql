MERGE INTO bonuses t
   USING bonuses2 s
   ON (t.employee_id = s.employee_id)
    WHEN MATCHED AND s.employee_id < 159
    THEN UPDATE SET bonus = DEFAULT;