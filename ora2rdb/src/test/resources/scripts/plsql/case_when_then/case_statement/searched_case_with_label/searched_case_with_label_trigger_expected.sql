CREATE EXCEPTION CASE_NOT_FOUND
	'CASE not found while executing CASE statement';

CREATE TRIGGER searched_case_trigger
BEFORE INSERT ON employees
AS
	DECLARE grade CHAR(1);
	DECLARE appraisal VARCHAR(100);
BEGIN
    grade = 'A';
    label_name:
	IF (grade = 'A') THEN BEGIN
		appraisal = 'Excellent';
	END
	ELSE IF (grade = 'B') THEN BEGIN
		appraisal = 'Very Good';
	END
	ELSE IF (grade = 'С') THEN BEGIN
		appraisal = 'Good';
	END
	ELSE BEGIN
		EXCEPTION CASE_NOT_FOUND;
	END /*label_name*/
END;
