/*
MERGE INTO bonuses t
   USING bonuses2 s
   ON (t.employee_id = s.employee_id)
    WHEN MATCHED THEN UPDATE SET bonus = 700
    WHERE s.employee_id < 160
    [-unconvertible DELETE WHERE t.bonus = 700];
*/