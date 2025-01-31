INSERT INTO (SELECT department_id, department_name, location_id
             FROM departments WHERE location_id < 2000 WITH CHECK OPTION)
    VALUES (9999, 'Entertainment', 2500);