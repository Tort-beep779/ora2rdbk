EXECUTE BLOCK
RETURNS (appraisal VARCHAR(100))
AS
	DECLARE grade VARCHAR(1);
BEGIN
    grade = 'A';
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
		appraisal = 'No such grade';
	END
SUSPEND;
END;


