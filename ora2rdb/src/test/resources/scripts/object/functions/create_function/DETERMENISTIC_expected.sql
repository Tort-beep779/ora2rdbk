CREATE OR ALTER FUNCTION betwnstr (
    string_in      VARCHAR
    , start_in       INTEGER
    , end_in         INTEGER
    )
    RETURNS VARCHAR
    AS
BEGIN
RETURN (SUBSTRING (:string_in FROM  :start_in FOR  :end_in - :start_in + 1));
END;