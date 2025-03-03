CREATE EXCEPTION exc_too_young 'exc_too_young exception';
CREATE EXCEPTION exc_too_young_2 'exc_too_young_2 exception';

CREATE PACKAGE errnums
AS BEGIN
    /*exc_too_young EXCEPTION;*/
END;

CREATE PACKAGE BODY errnums
AS BEGIN
    /*exc_too_young_2 EXCEPTION;*/
END;
